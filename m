Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6746BDA5F
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Mar 2023 21:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCPUtg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Mar 2023 16:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCPUtf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Mar 2023 16:49:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1272730E81
        for <linux-ext4@vger.kernel.org>; Thu, 16 Mar 2023 13:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678999723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=so3qFG339eU0WcPzgjTpfG6EeynpQDYCHVF6oNptDps=;
        b=c0mD5/l+s2c6i1G0PymBAEeLo2uD0+3Yykx1lyQPWtaQa+/pHfgJa3CSggI6512ao/Wr6q
        6C8BUUQ64SuJ3Zjn8yFwIThUnnnONFv0iTB25gOM5g7PVN+f0ydDZLYzpkJFfyKET+DwhK
        Olps8576E/WiU+9xRBu9ZxyD+bUiUMw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-tHdXI9H4NTiFnI2_xUZx-A-1; Thu, 16 Mar 2023 16:48:42 -0400
X-MC-Unique: tHdXI9H4NTiFnI2_xUZx-A-1
Received: by mail-qv1-f71.google.com with SMTP id f8-20020a0cbec8000000b005b14a30945cso1735927qvj.8
        for <linux-ext4@vger.kernel.org>; Thu, 16 Mar 2023 13:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678999721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=so3qFG339eU0WcPzgjTpfG6EeynpQDYCHVF6oNptDps=;
        b=m+n/0qnD27sMnEyCijHBCTqZz1hasRIR02fzFC/USzcWe76tzYV+EglT5Sn5oZaigl
         ZKvzbeRb7ICR8YcPTilrH8pHFYCLEqPlLa8eQ9XEF9+fJk98A/K59buZv4qdKApXY9P1
         nMYhAtQVh+9Sl4y2DXQfnj3mrwPO1IpRe/NwC27fN3ee4ULJ3XLioMmga3Feedf347Fl
         pa0FXtdpk2rFzqrCLHK8eEwVHZ1iiHtG4zf6wrkOP28+xDOMg/Dwvi7LXR9aCT9cnlMY
         mk/1d7Uon48SrP+TS28bkX7t02/woLkDopTKaWZNERe4ktSl8cbFZetsm5j7dIgBVd++
         JaMQ==
X-Gm-Message-State: AO0yUKWounhyop/WTDkDLGJ3eqa8gRpKFFV60e65/dCXh7phOATtXqz1
        uO3OeBbs0JbTQ22kQWMZ/Ebz/3RVddZIPDWtotBsbhcjvZPiFIOzLH7BvOp1byXoj5tu5+qJNS5
        7UPEDHQk0bkz2LAWPmxLVEg==
X-Received: by 2002:ac8:5e0f:0:b0:3bf:be7d:b3e5 with SMTP id h15-20020ac85e0f000000b003bfbe7db3e5mr9466327qtx.41.1678999721610;
        Thu, 16 Mar 2023 13:48:41 -0700 (PDT)
X-Google-Smtp-Source: AK7set8Whyb8vFNdaxwr/MNcdtIiEH3qdcW01Tns1x6/9oemqNNHEKPDuipZJ9O7h1rizKG+bdM1SQ==
X-Received: by 2002:ac8:5e0f:0:b0:3bf:be7d:b3e5 with SMTP id h15-20020ac85e0f000000b003bfbe7db3e5mr9466304qtx.41.1678999721376;
        Thu, 16 Mar 2023 13:48:41 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id n185-20020a3740c2000000b007402fdda195sm236462qka.123.2023.03.16.13.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 13:48:40 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ext4: remove unneeded check of nr_to_submit
Date:   Thu, 16 Mar 2023 16:48:31 -0400
Message-Id: <20230316204831.2472537-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

cppcheck reports
fs/ext4/page-io.c:516:51: style:
  Condition 'nr_to_submit' is always true [knownConditionTrueFalse]
 if (fscrypt_inode_uses_fs_layer_crypto(inode) && nr_to_submit) {
                                                  ^
This earlier check to bail, makes this check unncessary
	/* Nothing to submit? Just unlock the page... */
	if (!nr_to_submit)
		return 0;

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/ext4/page-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 8703fd732abb..b847131bc958 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -513,7 +513,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 	 * (e.g. holes) to be unnecessarily encrypted, but this is rare and
 	 * can't happen in the common case of blocksize == PAGE_SIZE.
 	 */
-	if (fscrypt_inode_uses_fs_layer_crypto(inode) && nr_to_submit) {
+	if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
 		gfp_t gfp_flags = GFP_NOFS;
 		unsigned int enc_bytes = round_up(len, i_blocksize(inode));
 
-- 
2.27.0

