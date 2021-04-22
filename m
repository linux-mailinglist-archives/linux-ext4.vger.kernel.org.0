Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0533694D6
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Apr 2021 16:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbhDWOgz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Apr 2021 10:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhDWOgw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Apr 2021 10:36:52 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2537BC061574
        for <linux-ext4@vger.kernel.org>; Fri, 23 Apr 2021 07:36:16 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id s16so43848992iog.9
        for <linux-ext4@vger.kernel.org>; Fri, 23 Apr 2021 07:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IXDpvkcejUXCXpaRmuHXYGVe9zxFDhtuQyaieXwMWQg=;
        b=Bfg4Cniqwnzld+WTSK//o0K7hYBXROK6rxdgTmkHervt+xZIymSmR0j1Av2/sw+1le
         vLFwR2ulloNI/B3Qq+IRa7Tm1zNSsuIzs2HR/deXiRIpVPmPscgCTJ7RsFBALJtzsZEZ
         /04KtNz1ZhZw3fKc7caV5g0bcWkA/o0QkW86wqbhXjAr40SrmfXZbPekQMoM6+WAxsYt
         UblczlVn/pKsMj9JC1fXgtI7Nx1bMEfEXDWI0hhdtEMnBVH83NXArWCGn5rNNwD/pxYL
         3jkgG4BjGUdCYRxFvhTlH7d/UjcqLnAdnJIgZ7sdllcIpr3vqmmsXE6PFJEGYTMtPqPt
         Gm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IXDpvkcejUXCXpaRmuHXYGVe9zxFDhtuQyaieXwMWQg=;
        b=XQMlecte/TAWxI0bS614oy7rbd+4pS3sIlKZS/BTUdbCNaN4znTFQOiAj41o9hmMQp
         46CuHLMFT8Gdl8TGnMKGGjA1oAVQYqxZunARKyFqw92hcTETSJq8SneH5hxM8D0pSs2M
         s5XuKpyFxKH8TKhgrFN0tYW5GfUBdFtH+sQBhMyC7dvFXZsL29YB4lv/8+zr/r5SKeW2
         PDi+Q7xx5zIqnL9RYXC1ApoHPknNLJOwOpo9J9vdHiUXLH5w/mXsgfxky28q6iroxjcq
         4pvMOKyI4/x/kit/5T+clZ26dSeLlsES5HYRg3mUuJ+nnSAT72uUIqMFRi/8nG8F7ty0
         m/8Q==
X-Gm-Message-State: AOAM532O+w3dhjIMmy7waJNCsPHNlp3ia5KN5bSdBGbKSj0spttTo9hj
        12ZR0Ilxapf6TFdeLzdjiJ2IBtolb2r3iw==
X-Google-Smtp-Source: ABdhPJySr5fc2VRZCT/G/1/OROugWU+4bOpEVbWgGkBZ7wTdtAe11INkHhumjN7K+T89x5eXVYU/Bw==
X-Received: by 2002:a05:6638:329e:: with SMTP id f30mr3941339jav.121.1619188575527;
        Fri, 23 Apr 2021 07:36:15 -0700 (PDT)
Received: from CO82.us.cray.com ([136.162.34.1])
        by smtp.gmail.com with ESMTPSA id u6sm2695577ill.78.2021.04.23.07.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:36:15 -0700 (PDT)
From:   Artem Blagodarenko <artem.blagodarenko@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        Alexey Lyashkov <c17817@cray.com>,
        Artem Blagodarenko <c17828@cray.com>
Subject: [PATCH] e2image: fix overflow in l2 table processing
Date:   Thu, 22 Apr 2021 01:24:48 -0400
Message-Id: <20210422052448.29802-1-artem.blagodarenko@gmail.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

For a large partition during e2image capture process
it is possible to overflow offset at multiply operation.
This leads to the situation when data is written to the
position at the start of the image instead of the image end.

Let's use the right cast to avoid integer overflow.

Signed-off-by: Alexey Lyashkov <c17817@cray.com>
Signed-off-by: Artem Blagodarenko <c17828@cray.com>
HPE-bug-id: LUS-9368
---
 lib/ext2fs/qcow2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ext2fs/qcow2.c b/lib/ext2fs/qcow2.c
index ee701f7a..20824170 100644
--- a/lib/ext2fs/qcow2.c
+++ b/lib/ext2fs/qcow2.c
@@ -238,7 +238,7 @@ int qcow2_write_raw_image(int qcow2_fd, int raw_fd,
 			if (offset == 0)
 				continue;
 
-			off_out = (l1_index * img.l2_size) +
+			off_out = ((__u64)l1_index * img.l2_size) +
 				  l2_index;
 			off_out <<= img.cluster_bits;
 			ret = qcow2_copy_data(qcow2_fd, raw_fd, offset,
-- 
2.18.4

