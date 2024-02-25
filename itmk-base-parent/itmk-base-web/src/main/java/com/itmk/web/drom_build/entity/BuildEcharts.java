package com.itmk.web.drom_build.entity;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@Data
public class BuildEcharts {
    private List<String> names = new ArrayList<>();
    private List<Integer> counts = new ArrayList<>();
}