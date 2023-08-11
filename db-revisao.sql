CREATE DATABASE db_revlab

USE db_revlab

CREATE TABLE aluno(
	ra INT CHECK(ra > 0),
	nome VARCHAR(100),
	idade INT,
	PRIMARY KEY(ra))


CREATE TABLE disciplina(
	codigo INT,
	nome VARCHAR(80),
	carga_horaria INT CHECK(carga_horaria >= 32),
	PRIMARY KEY(codigo)
)

CREATE TABLE aluno_disciplina(
	aluno_ra INT,
	disciplina_cod INT,
	PRIMARY KEY(aluno_ra, disciplina_cod),
	FOREIGN KEY(aluno_ra) REFERENCES aluno(ra),
	FOREIGN KEY(disciplina_cod) REFERENCES disciplina(codigo))

CREATE TABLE curso(
	codigo INT,
	nome VARCHAR(50),
	area INT,
	PRIMARY KEY(codigo))

CREATE TABLE curso_disciplina(
	curso_cod INT,
	disciplina_cod INT,
	PRIMARY KEY(curso_cod, disciplina_cod),
	FOREIGN KEY(curso_cod) REFERENCES curso(codigo),
	FOREIGN KEY(disciplina_cod) REFERENCES disciplina(codigo))

CREATE TABLE titulacao(
	codigo INT,
	titulo VARCHAR(40),
	PRIMARY KEY(codigo))

CREATE TABLE professor(
	registro INT,
	nome VARCHAR(100),
	titulo INT,
	PRIMARY KEY(registro),
	FOREIGN KEY(titulo) REFERENCES titulacao(codigo))

CREATE TABLE disciplina_professor(
	disciplina_cod INT,
	professor_registro INT,
	PRIMARY KEY(disciplina_cod, professor_registro),
	FOREIGN KEY(disciplina_cod) REFERENCES disciplina(codigo),
	FOREIGN KEY(professor_registro) REFERENCES professor(registro))

SELECT aluno.ra, aluno.nome, disciplina.nome FROM aluno, aluno_disciplina, disciplina
WHERE aluno.ra = aluno_disciplina.aluno_ra
AND disciplina.codigo = aluno_disciplina.disciplina_cod
AND disciplina.nome LIKE '%Lab%'

SELECT disciplina.nome, professor.nome FROM professor, disciplina, disciplina_professor
WHERE professor.registro = disciplina_professor.professor_registro
AND disciplina_professor.disciplina_cod = disciplina.codigo

SELECT curso.nome, disciplina.nome FROM curso, curso_disciplina, disciplina
WHERE curso.codigo = curso_disciplina.curso_cod 
AND disciplina.codigo = curso_disciplina.disciplina_cod
AND curso.nome LIKE '%Log%'

SELECT curso.area, disciplina.nome FROM curso, curso_disciplina, disciplina
WHERE curso.codigo = curso_disciplina.curso_cod 
AND disciplina.codigo = curso_disciplina.disciplina_cod

SELECT disciplina.nome, titulacao.titulo AS 'Titulo do Professor' FROM professor, disciplina_professor, disciplina, titulacao
WHERE professor.registro = disciplina_professor.professor_registro
AND disciplina_professor.disciplina_cod = disciplina.codigo
AND professor.titulo = titulacao.codigo

SELECT disciplina.codigo FROM aluno, disciplina, aluno_disciplina
WHERE aluno.ra = aluno_disciplina.aluno_ra
AND disciplina.codigo = aluno_disciplina.disciplina_cod
GROUP BY disciplina.codigo HAVING COUNT(aluno.nome) > 5


SELECT professor.nome FROM professor, disciplina_professor, disciplina
WHERE professor.registro = disciplina_professor.professor_registro
AND disciplina.codigo = disciplina_professor.disciplina_cod
AND disciplina.codigo IN (SELECT disciplina.codigo FROM aluno, disciplina, aluno_disciplina
WHERE aluno.ra = aluno_disciplina.aluno_ra
AND disciplina.codigo = aluno_disciplina.disciplina_cod
GROUP BY disciplina.codigo HAVING COUNT(aluno.nome) > 5)

SELECT COUNT(professor.nome) AS 'Quantidade' FROM curso, professor, curso_disciplina, disciplina_professor, 
disciplina
WHERE curso.codigo = curso_disciplina.curso_cod
AND disciplina.codigo = curso_disciplina.disciplina_cod
AND professor.registro = disciplina_professor.professor_registro
AND disciplina_professor.disciplina_cod = disciplina.codigo
GROUP BY curso.codigo