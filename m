Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4F2427304
	for <lists+linux-ext4@lfdr.de>; Thu, 23 May 2019 01:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfEVXk3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 May 2019 19:40:29 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:46156 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfEVXk3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 May 2019 19:40:29 -0400
Received: by mail-qk1-f179.google.com with SMTP id a132so2657834qkb.13
        for <linux-ext4@vger.kernel.org>; Wed, 22 May 2019 16:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Y4Dl+7lEOPRWc/UP3flRvEQzeq2trzFF+4H8YIdaO1E=;
        b=Rxn5mUip51tm7ESX8rjnbwE6yfO2rywxLfmlt5/grAz08+Pteg7TDmk3Jp+fhS8WRy
         70/L3V/+ZG72U97kTc3qBHRloz7/rWAQ2PI1UrGyG9BOWPex1u7zWH0pgAd3ll7qcvay
         5Fzg4xQdNm9N9DD5zNLbTMndSnZSiS/7s6CDQu0um0SSRwSWT0oagGpGl4ijUhkB16K1
         uMJs7FM8FfEupphOZzuVLdwMpo2ugxR/8X2OzekgljcFmxUuaMIWfWVo+AJwYCENpvCp
         VDXolhueLKr9IoU7shBiF0FNviH4fbzN9ElUo6mWLDMB9BrpgOnpZL7X4DQQJ6hDzqIA
         AvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Y4Dl+7lEOPRWc/UP3flRvEQzeq2trzFF+4H8YIdaO1E=;
        b=lxSQ+JqYosp1yD7P9pOLtJO4riwEDqpmBgB1JeEXCRZLUcag6FtNfilkgLixAwWkqn
         ZEjsD0Fb0p9P2C7q4hPyPZFPUAQrtuqinMXwLj0SA+uFh5Sats+TSv+5kV+NGZuH2P5O
         vztgmmBXeEkkdS+dXjj8tHLzwFB+ccYsNJrY5p5wUuDJDmnaFVOINU4v4i/kyympgMj+
         j3wsL1R+3iSBHfp6ENf8eI9KkmY/fuhkKQLFb2OdjeCwd1/7lv4AsI8jBR2Dran68Du5
         xexz7YxIN5+ge5ywJmr/2DselTuan1fXFCy/zMQzoBKN1t0p6NY4OmH9HHS4170aJwQL
         0R9Q==
X-Gm-Message-State: APjAAAW+gKnA6aCNuksEKzTRDsmAXW26SiIgn+/lQfNY4zbC6G8W/Lgt
        qf8sZa5ylBMV+AKPX1qPs9JygK5Yp+M=
X-Google-Smtp-Source: APXvYqxms+dYp2E5A1MoWQ4k7H8z3SKLW6cKK+sYTjFjLUJmBfUnT0me5KcIRLiRnTQvM+DZ1vS1ow==
X-Received: by 2002:ae9:ed91:: with SMTP id c139mr37567302qkg.211.1558568428292;
        Wed, 22 May 2019 16:40:28 -0700 (PDT)
Received: from ?IPv6:2601:153:900:ebb:74b5:9fcf:6f1f:201d? ([2601:153:900:ebb:74b5:9fcf:6f1f:201d])
        by smtp.gmail.com with ESMTPSA id t57sm15285639qtt.7.2019.05.22.16.40.27
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 16:40:27 -0700 (PDT)
To:     linux-ext4@vger.kernel.org
From:   Peter Geis <pgwipeout@gmail.com>
Subject: Ext4 corruption on linux-next since 5.2 merge window
Message-ID: <f79a1b38-898d-8bfa-37d6-a74ee97411e5@gmail.com>
Date:   Wed, 22 May 2019 19:40:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Good Evening,

Since the 5.2 merge window, I've been encountering EXT4 corruption 
periodically.
The board is the rk3328-roc-cc.
The device is a USB 3.0 Samsung SSD.
$ lsusb
Bus 005 Device 002: ID 04e8:61f5 Samsung Electronics Co., Ltd Portable 
SSD T5
$ lsusb --tree
/:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
     |__ Port 1: Dev 2, If 0, Class=Mass Storage, Driver=uas, 5000M
Currently running:
uname -a
Linux firefly 5.2.0-rc1-next-20190521test-14384-gea7592a68ff9 #64 SMP 
PREEMPT Tue May 21 14:40:53 UTC 2019 aarch64 aarch64 aarch64 GNU/Linux

The error received is:
[12546.303907] EXT4-fs error (device sda1): ext4_find_extent:909: inode 
#8: comm jbd2/sda1-8: pblk 60850175 bad header/extent: invalid extent 
entries - magic f30a, entries 8, max 340(340), depth 0(0)

This immediately knocks the filesystem to RO.

It is easily reproducible during kernel compilation.

I'm at a loss as to where to begin, considering the number of changes in 
various subsystems.
Is there some way I can enable more ext4 debugging?
