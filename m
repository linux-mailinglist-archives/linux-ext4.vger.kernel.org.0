Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7521966E6E2
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Jan 2023 20:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjAQTXB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Jan 2023 14:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbjAQTT7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Jan 2023 14:19:59 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E05241F9
        for <linux-ext4@vger.kernel.org>; Tue, 17 Jan 2023 10:31:50 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 20so16101269ybl.0
        for <linux-ext4@vger.kernel.org>; Tue, 17 Jan 2023 10:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wS36cR9T1WztTLryA73oiWbV/7g6SEmYhv85Qjk+duw=;
        b=RpwlO2S+aTG0MSTplQ8Aow0jnvBYbbx5YT+1lCq/WxvPi8cm7YMprUhq1L4nRA08q3
         PiiGcjeZDUiDHbAA8KHLifkRfXooow+GN6a7GXWkigAWGQfNwVraVb8QKKYeKSQPyy5r
         GLsDqPU7ExLZQv+9V4lPi8HVW86c1sMFD446CnRRnwANj1LEoSg1LX4Dq4I4DzM4cwhE
         K/rffofNJZLaE2MBBCLS7hdDXuQcd+ueZeCh+Yjbx+wkcAHwnE8oPfsi6tqHAGuIMjTl
         VsvLJ61qPHeA0auuGTpNBS0W+v/UgMO8rNVQdvAcNMb0INXgHS9uYql9Je5gZ70YHIeQ
         Lh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wS36cR9T1WztTLryA73oiWbV/7g6SEmYhv85Qjk+duw=;
        b=C0xKoOKcTIFU9cyBUmQATJ9Cq6Kxu8KuHVIUlrzXNwcUjlR1G8OLjwCq3Rsdpc8TYT
         aNDNgWmPR4WT5jXHGno7xkURp1SeieO4SUVYFwb49bXNGZpDhzKW6Gl7UtWW1ryCXqq8
         OCgfhlKLw6rAaFUjPviNl73J051gDcs1aHF9LX8bhbr/UzXdDBUF/e4Tb4dv8p3tpaKO
         Miy/NmFCukSX4Asrq/wlq0qN3u7NdGyl9I05kUBR70tqLupXGf+EzrGBr5OshVhdWtlM
         VfNfHweSdhapJ6oFcv+8jM4orqRkRBwzzzkm+vZ4XCfj2EYSRMRmWqwk5GgaxvC/58JJ
         3iqA==
X-Gm-Message-State: AFqh2krZWlr6h38bxUv4h9fvA3mv8kt1cvhpn1wGpevIVG5ZknBc8Bo5
        kh9mrMXAex1zGsD0G4MamO4HE6Z0lek=
X-Google-Smtp-Source: AMrXdXsE6WiLsa2inHb8/isiMds0UyrCGWnVZGrrfdxjcZs6bX9IppyrPBMYT3ExzS6b4/oAHfRFFg==
X-Received: by 2002:a25:348b:0:b0:7f3:de9b:de2c with SMTP id b133-20020a25348b000000b007f3de9bde2cmr6482yba.22.1673980308532;
        Tue, 17 Jan 2023 10:31:48 -0800 (PST)
Received: from debian-BULLSEYE-live-builder-AMD64 (h64-35-202-119.cntcnh.broadband.dynamic.tds.net. [64.35.202.119])
        by smtp.gmail.com with ESMTPSA id x23-20020a05620a0b5700b00706a452c074sm1137536qkg.104.2023.01.17.10.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 10:31:48 -0800 (PST)
Date:   Tue, 17 Jan 2023 13:31:46 -0500
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Subject: generic/454 regression in 6.2-rc1
Message-ID: <Y8bpkm3jA3bDm3eL@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

My 6.2-rc1 regression run on the current x86-64 test appliance revealed a new
failure for generic/454 on the 4k file system configuration and all other
configurations using a 4k block size.  This failure reproduces with 100%
reliability and continues to appear as of 6.2-rc4.

The test output indicates that the file system under test is inconsistent.
e2fsck reports:

*** fsck.ext4 output ***
fsck from util-linux 2.36.1
e2fsck 1.46.2 (28-Feb-2021)
Pass 1: Checking inodes, blocks, and sizes
Extended attribute in inode 131074 has a hash (857950233) which is invalid
Clear? no

Extended attribute in inode 131074 has a hash (736302368) which is invalid
Clear? no

Extended attribute in inode 131074 has a hash (674453032) which is invalid
Clear? no

Extended attribute in inode 131074 has a hash (2299266654) which is invalid
Clear? no

Extended attribute in inode 131074 has a hash (3503002490) which is invalid
Clear? no

< and continues with more of the same >

The failure bisects to the following commit in -rc1:

3bc753c06dd0 ("kbuild: treat char as always unsigned")

The comment for this commit suggests that it's likely to cause things to
break where there has been type misuse for char;  presumably, that's what's
happened here.

Eric

