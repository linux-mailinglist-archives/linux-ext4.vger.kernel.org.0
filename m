Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA7D1F86C8
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Jun 2020 06:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgFNEpv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 14 Jun 2020 00:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgFNEpu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 14 Jun 2020 00:45:50 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7621C08C5C2;
        Sat, 13 Jun 2020 21:45:49 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x22so6321913pfn.3;
        Sat, 13 Jun 2020 21:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/YXgQCn0zrgR49JfvgzrosE8wv5QZY9x0gXhrf0GGsw=;
        b=kCTPcsC5tJRcZ5u6nrgR2c9aGSl4dPEu4YvdQo7W5oAVEZp6EoQ3orDR7KSrg5tkw9
         8JDJw1wVagb1Nb/dVHN9Gbyeh/CkG0z9V+reZXLv/yCs6mJevc09NpWAl5MG6YWIY9uT
         6NAyVxjqr7y0zLIoe0RwpMBd2SqpOETmk0vekVuavXXTO6qL/fzyfaT117iq07bKrrZs
         vc2vSL98+ogxUqknkSX+uLYelucSN8/4RpejE86uLRnRcPftuXXzydmUOW1u2Q/ecxXc
         DES+03aBbCA8G0MEDqVFyL2dY4OxNnI0bLkSHbsb8w/NVVeM7jMiGc7p9qpZSZw+aTN4
         8vSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/YXgQCn0zrgR49JfvgzrosE8wv5QZY9x0gXhrf0GGsw=;
        b=p0koBUC3uua4yD9yLkgI9Js5ng9wIMiAciW3dL0b1x/cKqkeYy7dKn84VYlYmCAXp3
         i1i85bQzEYNgdXR6xTN81IDIcnGrVMszqXcXNxud29DIdJas5aXdzJUQwuy72ZIt2g0O
         a8kCRoXEBnlRKatDstuvsdYUJiCTfKL2VhIV1uOeaLpmSMceFD5oEiVP8IMREehtIUTI
         tQOzc6wvK3HybXWVjO87HNSD7MA5r5ZeCtFLcfbQ+pN8suiVDiYMxCJIGJXUZBU6R2Ph
         FYevfRAoT8pw0B/ziezqLXcKrJBKfjlLOOoS78xS1rOi6jHgwAVirW9h3Bhs/GJpj1gx
         AKwQ==
X-Gm-Message-State: AOAM532Bqi4KOFcmtg7vvyf+yfmnyOa2SS29AxFTck3iIwAb1S5JxAL9
        QRc07yrbs8+3RriBpmEZ4KaqaOfE
X-Google-Smtp-Source: ABdhPJyhTNvT09JshTimknf2cefDP/4JYK075PIauZOG0xgz6/XtEkWBgEp0bYM8YBkZ7w24gRKNgQ==
X-Received: by 2002:a62:2b55:: with SMTP id r82mr18905403pfr.68.1592109949009;
        Sat, 13 Jun 2020 21:45:49 -0700 (PDT)
Received: from ASMDT.1 ([182.1.234.31])
        by smtp.gmail.com with ESMTPSA id z144sm10693791pfc.195.2020.06.13.21.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2020 21:45:48 -0700 (PDT)
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Dio Putra <dioput12@gmail.com>
Subject: [PATCH] ext4: fix coding style in file.c
Message-ID: <239fcd8f-d33f-8621-9e82-0416dd3f9c94@gmail.com>
Date:   Sun, 14 Jun 2020 11:45:44 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fixed a few coding style issues in file.c

Signed-off-by: Dio Putra <dioput12@gmail.com>
---
 fs/ext4/file.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 0d624250a62b..10e4a8389885 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -145,8 +145,7 @@ static int ext4_release_file(struct inode *inode, struct file *filp)
 	/* if we are the last writer on the inode, drop the block reservation */
 	if ((filp->f_mode & FMODE_WRITE) &&
 			(atomic_read(&inode->i_writecount) == 1) &&
-		        !EXT4_I(inode)->i_reserved_data_blocks)
-	{
+			!EXT4_I(inode)->i_reserved_data_blocks) {
 		down_write(&EXT4_I(inode)->i_data_sem);
 		ext4_discard_preallocations(inode);
 		up_write(&EXT4_I(inode)->i_data_sem);
@@ -797,7 +796,7 @@ static int ext4_sample_last_mounted(struct super_block *sb,
 	return err;
 }
 
-static int ext4_file_open(struct inode * inode, struct file * filp)
+static int ext4_file_open(struct inode *inode, struct file *filp)
 {
 	int ret;
 
