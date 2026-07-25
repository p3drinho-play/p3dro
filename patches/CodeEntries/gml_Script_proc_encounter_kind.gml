if (argument2 >= 45 && (argument2 % 45) == 0)
{
    return 2;
}
if (argument2 == 15 || argument2 == 25 || argument2 == 40 || argument2 == 60)
{
    return 1;
}
var _late_gap = max(10, 35 - (global.proc_alpha_bonus * 5));
if (argument2 >= 95 && ((argument2 - 95) % _late_gap) == 0)
{
    return 1;
}
return 0;
