Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2700690B94
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Aug 2019 01:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfHPX4I (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Aug 2019 19:56:08 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:40846 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfHPX4I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Aug 2019 19:56:08 -0400
Received: by mail-ed1-f42.google.com with SMTP id h8so6498826edv.7
        for <linux-ext4@vger.kernel.org>; Fri, 16 Aug 2019 16:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3huj0oeyup9M9DIiU9x1xOojU9xk1ZMZIp6mMJ9v6HA=;
        b=KtOSfd9iaPzsM9DSOvgtP2A/bs3tWeODa4rHs1bTT/YBQFmeAFxLCMMjELQNLTrZiy
         2H8EBg6Zy2y8YExYoa9OSI6QTSao97r/W9Ov0N0XR7+fxI5UWHm6Zt8rwQy4DjsPo3Pt
         mvVWI14hMR6KNzsjHO6+8+uSdsp1NGtv58QkpiaE/A2iE1yYNmOAaq0QvGV5fGiw7Nrc
         JIzRPkiQsr6guWTQnB/Uc2tFzGQyIz5o/yeP4IA4jvDTt1y95TqqHGqSC9K03D1u6bAL
         kijCafd3GPywaVVy+sqY7eDeFnaSdE3i9x0lHbMnqdNEx7W+UmBUDK/gQyzOZMrRxkhp
         0qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3huj0oeyup9M9DIiU9x1xOojU9xk1ZMZIp6mMJ9v6HA=;
        b=RsGyNFeE+/JKlJQ+U8cW/TlkQeoIYaIH1vtYKIapIJ6D75hFQs3k7mU9oriFjITgFv
         tUhX4ahxoitEbENIGNdY9MpOvT4/Kp1/dUagP5L1SgOO+97O4r7LohWMUlRnCykTCjER
         NXYbGYp6y3fuNNxCMThqKD9h8fs/nNHte4F0igqhXxHcuHzrbqJBe7ivTjEPngNJ6Uf5
         bidRi/abFa8CM27Y9Nsqq2uQFEfBRXaa2+OybAccgToPQrFkV6tjZB/Ffa4vqMf5qybo
         YY0VQrCVozoVe33fPjKDcSvF3Sc0dLEpaIS8clmYhzO1UM9Vm8hRHVdz3ftmg+UyST0S
         bvZg==
X-Gm-Message-State: APjAAAUip12MFpyGwW2UxThmAPUXw1lfDZpCxku9ar7x+Z6199tUT8nC
        oigeKACyWrnnvlICTr9FoNVjYVzwTnnnE0+MwmZ0rtIqXf4=
X-Google-Smtp-Source: APXvYqyluVDkCxY9Ohq5eRKJc6jpvTktAWPJ3zKFbl7XQrxkf6epQnLQMjQh50VdcxwxcYAjRhWP8IjEBM0lHHMaXbU=
X-Received: by 2002:a50:90a4:: with SMTP id c33mr12829612eda.106.1565999765976;
 Fri, 16 Aug 2019 16:56:05 -0700 (PDT)
MIME-Version: 1.0
From:   Shehbaz Jaffer <shehbazjaffer007@gmail.com>
Date:   Fri, 16 Aug 2019 19:55:54 -0400
Message-ID: <CAPLK-i8xE4n8BJ-Beu0f80PC2W6b-A30nwcz+V_bCb_iAyB++Q@mail.gmail.com>
Subject: question about jbd2 checksum v2 and v3 flag
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

I am trying to understand jbd2 checksumming procedure. I reboot ext4
in the middle of a metadata intensive operation using echo b>
/proc/sysrq-trigger. I see that the journal gets replayed on next
mount using prinks in jbd2/recovery.c: do_one_pass() function.

I then corrupt intermediate metadata logged on jbd2 and I still see
the journal being replayed without multiple error messages which
should ideally get printed when one of the two following flags -
JBD2_FEATURE_INCOMPAT_CSUM_V2 or JBD2_FEATURE_INCOMPAT_CSUM_V3 are
set.

I have 2 questions:

1. Are the two flags: JBD2_FEATURE_INCOMPAT_CSUM_V2 and
JBD2_FEATURE_INCOMPAT_CSUM_V3 set by default? If not, how do we set
them so that the journal will detect and respond to injected
corruptions?

2. this is very naive question, but what do compat and incompat
options mean? If flag X in incompat is set, does this mean the feature
does not exist?

Thank you,

-- 
Shehbaz Jaffer
