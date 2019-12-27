Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFE112B4EF
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Dec 2019 14:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfL0NrC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Dec 2019 08:47:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34979 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfL0NrC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 Dec 2019 08:47:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so26114292wro.2
        for <linux-ext4@vger.kernel.org>; Fri, 27 Dec 2019 05:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yZ/6rUUablOcK/gSYaJ1J/S/ZDD9h2V3ve00gP29MQk=;
        b=THit34ZiuBw3+jK+KFUpFLkmYXbdb8/ZNnqSHVM3awyzn328KcupVxnWUwSM0HHhJp
         eBw/DlTUztk8K/20SSqzjfR89ps7DzEs438AAVC8HjyTJjyQ542rT077LvEIJ/hWTZtC
         MsaqUYZsWOc6LvyRRypYMnmqzN11zLaVxArrLwr0ckZbEUyo9j0n0bYxO8JAp/D8Eb1p
         8CsiT5HyvC5Etjl5tMPJCge/VpZsPMp1+20XOGQm8TE33+xjvJnNYN6yLGxYX4a6Nbh4
         mmrnaVp61OyGX/itgnT7Y/fre7Vz4CvcR1TiVLvL3hIA0h5Ramj0K2MMMU/LUjQOt4El
         Tqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yZ/6rUUablOcK/gSYaJ1J/S/ZDD9h2V3ve00gP29MQk=;
        b=Cx3wuxcEn0dLYLj6z+gb9OFWzhh8i5MHylQu9uXipINIjU9QMZE8WwKAxPC7OzDiEN
         /ZqT3nmX6CgmqDIw4FjjqGqbamSgkQ5Vc1jTn5i8NuQvHl4vd4lJAKQvm/qzSuGCP3af
         cHS6E98sDR7gxOfNdIGKD95LMVTkAY64HpGgu4IcGBEeYBa61tcExhAcgP2LHT68mbKo
         RSEVK0F+Vp/Yk3qBnlnBHmDBcCiCmvNwcRPzMbnFf+xPfa1E+tL3CHdcXCnmZeX/DD5v
         TQOqAsB+fqNJ/E9Ur+5ANc1cMMXggpGsQ6I7RY8LME0RcFtTfiFfCIy7mDN+G4E32krz
         55iw==
X-Gm-Message-State: APjAAAU8R2cvYABozJJ5kfNPUFJNITaKzXyjExqmLlTucW3mJZWPHD05
        jH8LKCDsmWsH9N43ndzPlnvU1Q==
X-Google-Smtp-Source: APXvYqz5bF4p5vRQNTNOjHdV17xFXC4IuIbpDB90AxO030jdtkF1VMtwEkIyLQC/u0SoPSTSkeoWQQ==
X-Received: by 2002:a5d:4045:: with SMTP id w5mr47677833wrp.59.1577454420599;
        Fri, 27 Dec 2019 05:47:00 -0800 (PST)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id b10sm35648532wrt.90.2019.12.27.05.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 05:46:59 -0800 (PST)
From:   Martijn Coenen <maco@android.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, sspatil@google.com, drosen@google.com,
        Martijn Coenen <maco@android.com>
Subject: [PATCH] ext4: Add EXT4_IOC_FSGETXATTR/EXT4_IOC_FSSETXATTR to compat_ioctl.
Date:   Fri, 27 Dec 2019 14:46:39 +0100
Message-Id: <20191227134639.35869-1-maco@android.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

These are backed by 'struct fsxattr' which has the same size on all
architectures.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 fs/ext4/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index e8870fff8224..a0ec750018dd 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1377,6 +1377,8 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case EXT4_IOC_CLEAR_ES_CACHE:
 	case EXT4_IOC_GETSTATE:
 	case EXT4_IOC_GET_ES_CACHE:
+	case EXT4_IOC_FSGETXATTR:
+	case EXT4_IOC_FSSETXATTR:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.24.1.735.g03f4e72817-goog

