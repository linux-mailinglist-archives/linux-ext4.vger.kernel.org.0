Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3590C23B0A3
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Aug 2020 01:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgHCXCO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 Aug 2020 19:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgHCXCN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 3 Aug 2020 19:02:13 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D829DC06174A
        for <linux-ext4@vger.kernel.org>; Mon,  3 Aug 2020 16:02:13 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u185so19138561pfu.1
        for <linux-ext4@vger.kernel.org>; Mon, 03 Aug 2020 16:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=V/+z/hxKFgTteJODvKkcx/ojBZuakxz0j5YHjVIKU/I=;
        b=WvzRhMuo+Bhq3EFBZdXi/SgHsTe8rpKDUkQkc9iu++WXSNIDqmVy3dDn8sRLN7T/eO
         I5z/tJlNF/CoQPYbXeY4zyQgcBzx/NK7gKR3VSmsCWbt4a63wjrorNpU5oK7/o9EZOb7
         GbPlkTi5doGkvngQDeNHiK7aW320dZCIeL6HC7a4lnD8VLxmcvn2u4EPPsXE6V8IUM3m
         rPVkbrqrwSUqWpNEvZvM+Kf+klqLwtyeqrppMj6Cn+IIGyxakTB42svkyBYmfeLCtMtf
         tqEgDHKaHqyaEZ2+YlffH0DefvxZ20+vvWxiUoEvuAKYotl5pPF6eEfaTbizpQyCOlUy
         97SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=V/+z/hxKFgTteJODvKkcx/ojBZuakxz0j5YHjVIKU/I=;
        b=gPVGE3P3k7peTALQE1XSIwlLjCky7JZHAp9qhVmcKIBeBP+JqnOU1BfQWL6621XM7i
         RpWCkxuCofXQzOJCJK0AonV7zymQeH+qKdtgpSmFEO5a0Pi/jZvoPE/ENEizw2PqBOxl
         2+oMlJqAP5RBvBEysj3mVG+zzBlEIh/i2ut2C3zdfdgNE7+vp1Mv8Z1TXL993JeLqFD3
         cC+IUFmi8qJcqd5B40eJwdjZVP9yZJBxwrEwo84UFrS9ViJWOxGqw/gYaRx6xlm2fssk
         xtAAaoCw+Oiqh2hwRf5OJ2jVm00R4ODpLDyVVu0R/LpvCVUxPGDb5f1TRrI/JjMdDXpY
         IDlA==
X-Gm-Message-State: AOAM531Ks3QaAJbiznUIk5ql2K4/dS1rRTjfKxKAPSwsH28Z/zO2wMKL
        MXDR7WJ8k1MSM3X8s5ZwD9E4nQ==
X-Google-Smtp-Source: ABdhPJxYaNOzfp7Coaq7/S3GFzQRaWKpMjthMCF1MVEAbgu6MXquqj4sTaj7nUYP30nuW+UakDmt1Q==
X-Received: by 2002:a65:438c:: with SMTP id m12mr16411217pgp.373.1596495733364;
        Mon, 03 Aug 2020 16:02:13 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id r185sm21403864pfr.8.2020.08.03.16.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 16:02:12 -0700 (PDT)
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] ext4: flag as supporting buffered async reads
Message-ID: <fb90cc2d-b12c-738f-21a4-dd7a8ae0556a@kernel.dk>
Date:   Mon, 3 Aug 2020 17:02:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4 uses generic_file_read_iter(), which already supports this.

Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Resending this one, as I've been carrying it privately since May. The
necessary bits are now upstream (and XFS/btrfs equiv changes as well),
please consider this one for 5.9. Thanks!

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 2a01e31a032c..1e827410e9e1 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -839,7 +839,7 @@ static int ext4_file_open(struct inode * inode, struct file * filp)
 			return ret;
 	}
 
-	filp->f_mode |= FMODE_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 	return dquot_file_open(inode, filp);
 }
 
-- 
Jens Axboe

