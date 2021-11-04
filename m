Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCB9444EFC
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Nov 2021 07:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhKDGmx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Nov 2021 02:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhKDGmt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Nov 2021 02:42:49 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE05C061714;
        Wed,  3 Nov 2021 23:40:12 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id m14so4881223pfc.9;
        Wed, 03 Nov 2021 23:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dD8s4IYG4kT2RxJ4GnuCWL3Z9PW6WLYB/CeRNH0qNhU=;
        b=UPs204fj6vt/U30BQdmIV/Gixbq2uz9Qs19x0vuvJePmUrOsaUNSyGJ2LLCOM+g6qp
         Zt0D0a3h2bHtnLiWeuJcUJoiEKgILQLCpginjF7EGs5hUuTT2mHkgJkatujOCbDXMhMj
         i3gNQ90T6Xh4XCqebqtlgxR+gLiF/d9Bje/V1Wcx7C4dae2V4EP5igGwVJvVbRj8808b
         fqah7ax8swi6ai7vmKlozTZVrv802LVFODjetPUqDk+43A2K7UG22GynKJoHqlifB0l1
         K+jXLTcfXOVz6V6hFylwWfPf4SeJiQnBrammbkFwSFyyy4TnMRF61kxL5vPdHcY8z45w
         CH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dD8s4IYG4kT2RxJ4GnuCWL3Z9PW6WLYB/CeRNH0qNhU=;
        b=lKdi4YhuZqPJvg28jCk1S43qdN7+zm18679GFWnUOPPOA89FehlBp8rgQjPI7LyARD
         Nb938CrrfgmSQH6KlyOFlUX+l3Jd2HiYlKBc02CmNfvwZtX9wd4Poh7zxHRJDwOcFz6S
         BPLKrdp/4J46lziGycm7q474uyqf15lgfLZ8CTZi5Q6pFpDlWmu3sI4YMMHvYOJQOD2J
         6hsM18xMAFvTPGVo8QK3p+4TAExlrMK5XHmeEgy4vds3rCW8xwvQQUeJBcNGnf5x/uK8
         ELfQ6H95+ix/2dbzEtiHFgrbyzKsvgX77N1NWHekhVvstSnaLitpPB7ESO0A3NUH3nEi
         0BPw==
X-Gm-Message-State: AOAM532y04j+nU65CdSelTBXBNA4IEQPDe6B+ANtA1MLZfHCDw7eHRVi
        ZwInZ4oYLkazdgh8boz2lbU3g3f2VJA=
X-Google-Smtp-Source: ABdhPJzPszM4GhaX9XwGX4Dd2ivZ3nn4Zj+L5WqbMU3PGoE5JD8u1SX3G2I8hlDAD7HvJxPMN2sOfA==
X-Received: by 2002:aa7:8a56:0:b0:494:6b49:cbfa with SMTP id n22-20020aa78a56000000b004946b49cbfamr571012pfa.72.1636008011856;
        Wed, 03 Nov 2021 23:40:11 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c85sm4316597pfc.146.2021.11.03.23.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 23:40:11 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: luo.penghao@zte.com
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] ext4: Remove unused assignments
Date:   Thu,  4 Nov 2021 06:40:07 +0000
Message-Id: <20211104064007.2919-1-luo.penghao@zte.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: luo penghao <luo.penghao@zte.com.cn>

The eh assignment in these two places is meaningless, because the
function will goto to merge, which will not use eh.

The clang_analyzer complains as follows:

fs/ext4/extents.c:1988:4 warning:
fs/ext4/extents.c:2016:4 warning:

Value stored to 'eh' is never read

change in v2:

Repair the sending email box

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 fs/ext4/extents.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index b1933e3..9ed8a15 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1986,7 +1986,6 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 					+ ext4_ext_get_actual_len(newext));
 			if (unwritten)
 				ext4_ext_mark_unwritten(ex);
-			eh = path[depth].p_hdr;
 			nearex = ex;
 			goto merge;
 		}
@@ -2015,7 +2014,6 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 					+ ext4_ext_get_actual_len(newext));
 			if (unwritten)
 				ext4_ext_mark_unwritten(ex);
-			eh = path[depth].p_hdr;
 			nearex = ex;
 			goto merge;
 		}
-- 
2.15.2


