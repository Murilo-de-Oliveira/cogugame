// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//@function scr_get_xp_for_level
//@description calcula a quantidade de XP necessária para o próximo nível
function scr_get_xp_for_level(_level){
	// exponencial simples
	return floor(100 * power(1.2, _level - 1));
}