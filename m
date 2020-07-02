Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3688C2119D8
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Jul 2020 03:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgGBB4Q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Jul 2020 21:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgGBB4N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Jul 2020 21:56:13 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0A0C08C5DB
        for <linux-ext4@vger.kernel.org>; Wed,  1 Jul 2020 18:56:12 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id r12so17405131qvk.3
        for <linux-ext4@vger.kernel.org>; Wed, 01 Jul 2020 18:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WYYjT2/hNkPnR18Pb1O8vFno0wa46kUGqnYNvHL7CO8=;
        b=tE480u3ZUDpqAtXxYSVcguCdzzrzALwE6zI3bPe2vn+SuGlP3liwfHHHvL7swR0yMi
         +45EfUoHTPXQCu9zATcjsa7XTIWLnCAI++nTFeCLpDRA2toC30VuhXpn9g1jI9rYhhhn
         owIppilepJsHj+LPh+QsM8Em2spEhl/n62X+tGggOvMqu4ZN9TDOTCjuTny6pAFUpofY
         KrDRgD/CktEvl7kqVfWqcoEFfOsbQf3sxDDR0Kdzxx2D02/3jgq4C15pD2o8Zl+WNBfX
         ZC9wYW7TdUfekssuIV6Htv0dh3C1BN/RCHaeUPP7UK9Q5X4nh4SX8N89kzmJQedZMbhM
         tXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WYYjT2/hNkPnR18Pb1O8vFno0wa46kUGqnYNvHL7CO8=;
        b=Xt/zYASgiWCQg1p1Ppn8xZVja2kW8hm+cEeUUuOKtrjSQiQfeykBCV4HciyXVmRiYR
         vHtaPTBLT1H8m4nQo+h58Hd9hnaULLMyBBEcc//fijipLfaCZrH0zdGVOlPKLaT3t+yd
         nV392C6j8gqFoVscrHpTlJ0q9MJ6x4t9tEx//s3n6EwOez+c2fujI4m1Br3wLXmAjK+U
         sOQDNRpSRohkGhC1vboUUtQQl5s73QNdAnqiUs2vXwJfTuj7TowhDknywMD7Kl07xOwK
         x08IirFJzHHo33sL91xXlSHc+xBuYLiy7Cc+Xp2wNOgrRm1BsJGBirfcit0PO17Llb5h
         cQ9g==
X-Gm-Message-State: AOAM5332GtGu8ggd3MwjqFzPs+cQymC46fsc8GGIW0CG3kX1IItIhnip
        ttKzo3WAEQqTBRW/p+JZ4YYlm7f3vns=
X-Google-Smtp-Source: ABdhPJw+Vx/ya5wGYQKZwKo1tFC7kcryv/M/vWd9ShnuevalVhxz9zBVlVp5rW01dFcIXaBSnTXp03G53EU=
X-Received: by 2002:ad4:4a64:: with SMTP id cn4mr27785568qvb.199.1593654972074;
 Wed, 01 Jul 2020 18:56:12 -0700 (PDT)
Date:   Thu,  2 Jul 2020 01:56:04 +0000
In-Reply-To: <20200702015607.1215430-1-satyat@google.com>
Message-Id: <20200702015607.1215430-2-satyat@google.com>
Mime-Version: 1.0
References: <20200702015607.1215430-1-satyat@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v4 1/4] fs: introduce SB_INLINECRYPT
From:   Satya Tangirala <satyat@google.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     Satya Tangirala <satyat@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Introduce SB_INLINECRYPT, which is set by filesystems that wish to use
blk-crypto for file content en/decryption. This flag maps to the
'-o inlinecrypt' mount option which multiple filesystems will implement,
and code in fs/crypto/ needs to be able to check for this mount option
in a filesystem-independent way.

Signed-off-by: Satya Tangirala <satyat@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3f881a892ea7..b5e07fcdd11d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1380,6 +1380,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_NODIRATIME	2048	/* Do not update directory access times */
 #define SB_SILENT	32768
 #define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
+#define SB_INLINECRYPT	(1<<17)	/* Use blk-crypto for encrypted files */
 #define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
 #define SB_I_VERSION	(1<<23) /* Update inode I_version field */
 #define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
-- 
2.27.0.212.ge8ba1cc988-goog

