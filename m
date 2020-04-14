Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD081A8599
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Apr 2020 18:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440256AbgDNQsK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Apr 2020 12:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439829AbgDNQsG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 14 Apr 2020 12:48:06 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E6CC061A0C
        for <linux-ext4@vger.kernel.org>; Tue, 14 Apr 2020 09:48:03 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id w145so305141lff.3
        for <linux-ext4@vger.kernel.org>; Tue, 14 Apr 2020 09:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=I4stk8sV9DovzFljt6yikH9oBsBWJ7Dw5ET7aegIIAs=;
        b=XETz8x2O0dx/C38e20PX7g/OHAAKUVPE2pDcBPnceYKfGk1wORNAO1z3y5whqcH7jL
         DMjvSXVlDqgJA6sWpmi8iO6aDnh/uHzr0D8Jk+0XGAQAcG/SvPNRGaFtiM5BQSXycCkc
         FMFRUOGjMpHND1yWpp585bZcg81/GrYNcD7aY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=I4stk8sV9DovzFljt6yikH9oBsBWJ7Dw5ET7aegIIAs=;
        b=UiJgNj9dQsUR7jDpl8wovC/kPcp+w+bjHblxXFoLfAtQzh6u0jgQVKFCfvp8CnWuvD
         wYCwML+IQTKetlz0oZjbvNlhtjZmna29SeXsTPJqBBKRgoAd2Ws3Irm39dSMH2j3jGDf
         LZhg6c8sGWL0L/dmkv8uPvrDvUbI+7P7WLP9oJAbt6WsF2logWebKJUrAT0KLIBr8v1J
         cOdAHcMbdEusPeDpnyD2YhSg5BEdO4T6MpE004ZTg6HRgbWB78GYFO5S1/KwVYVRGok+
         mDZ+yCBEitJ3xPMVLGZ2YdhLCxbesQa7qRhat7+o4fuHLGx1tVTbknj9piWbf4H6Ccrp
         EFtg==
X-Gm-Message-State: AGi0PuZozFHlsSb5KXiStzcdGIi+Zbx7OaoC6HteugSvjFA2uJLfnlld
        6L5yl3o00b5fbe2xFwSvYS+EjGoRxFuTmg==
X-Google-Smtp-Source: APiQypIoxIVz8nKkd2UTAhDf+Mndg+dmecMUf7JyK5bVbhEWfdvdbnSpG51ZSSk3v2l/sp5wZ/SJ+A==
X-Received: by 2002:ac2:5c45:: with SMTP id s5mr459224lfp.28.1586882881850;
        Tue, 14 Apr 2020 09:48:01 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-116-45.cgn.fibianet.dk. [5.186.116.45])
        by smtp.gmail.com with ESMTPSA id q9sm11637637ljm.9.2020.04.14.09.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 09:48:01 -0700 (PDT)
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: comments on "ext4: don't assume that mmp_nodename/bdevname have NUL"
Message-ID: <1e3f607b-a23a-dbd6-b695-cfa0fe38d7e6@rasmusvillemoes.dk>
Date:   Tue, 14 Apr 2020 18:47:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The patch in $subject (now commit 14c9ca0583ee in mainline) says
snprintf does not guarantee nul-termination. If that was ever the case,
that is a bug in snprintf that needs fixing, but I don't believe that
ever happens. If called with a non-zero (well, and sane, i.e. less than
INT_MAX) buffer size, the kernel's snprintf is guaranteed to produce a
nul-terminated string.

It's true that mmp_bdevname is filled in via snprintf (via bdevname ->
disk_name), and bdevname assumes given a buffer of size BDEVNAME_SIZE,
so certainly the added BUILD_BUG makes sense. But perhaps the struct
member should just be sized BDEVNAME_SIZE instead of 32 (unless that
leads to #include madness). [If I'm reading the code right, and that's a
big if, the bdevname() in kmmpd() is redundant as the very same
mmp->mmp_bdevname was already filled in when the kthread was created.]

However, mmp_nodename is filled via a memcpy from
init_utsname()->nodename - the latter is actually (AFAICT from the code
in kernel/sys.c) always nul-terminated, but we're only copying 64 of the
65 bytes, so of course the copy may end up without a nul-terminator in
those 64 bytes. In that sense the commit does fix a potential problem,
but it has nothing to do with snprintf().

Rasmus
