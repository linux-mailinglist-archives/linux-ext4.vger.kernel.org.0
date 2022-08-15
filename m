Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B27592F3B
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Aug 2022 14:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiHOMwk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Aug 2022 08:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242580AbiHOMwi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Aug 2022 08:52:38 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD18815A3A;
        Mon, 15 Aug 2022 05:52:37 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id w14so6238215plp.9;
        Mon, 15 Aug 2022 05:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=oUP2B+giqSGNR3ACWugRNBN3GDKqU3WAK33oCFRQAYc=;
        b=SqvzyBZ1n5nwtY5A/UFiT+gf8xPJ+5JrU03vyvlr5ock3435u1fUlPwmG/nVCNE392
         NEHIMKNXTmKnImXkr/3JuYcHfGw3rsDZDl+NxtUr02YfKmPC/BaV7M7mYiXqDXFe2120
         ycvDEYHbCxml1NQorbZX7VivEBqc7IOWUm0p9WLWj3XZ0M2vOq+Ek16DEtLup+E/Hbsk
         4VKdONANZFZhoZyuw08+YATtJZIcP5Vu3BiOeR5cQdAtbveNHkhanJ6P0dBUEeXrMWoN
         MhPF6BTWKSokQTaNcYB/pSd/zAYmfDadeorqprdW84kG2X0IEBko8jzrcYtHH/XDv2gi
         fIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=oUP2B+giqSGNR3ACWugRNBN3GDKqU3WAK33oCFRQAYc=;
        b=ZJ8qNZIeNShFzrZuQHCABSAHKbdYLCaOr1KjE3veSU8T00dxO38DtBiAy3nbRxisBR
         Qf2PiQGEdBAKjnoX3HK5EQiPhLZPAMi5OEX5b6OtceOXaV++GPExV+Vp8z9c2ipmwJ1J
         NKWO1T8jfVMixvw0CWQsByUQoKV8ENlWkvI8IBGj45gBKsZhcEbviJ33Iugx5DLTrk/B
         RlgIQCvbnPoQbjnfOiP2Ei8G2qTtwx/QzLCX0VPmVesNsjUc7V7nufGDzAeyJDU+thWH
         /oE4Qo47YjDi2lFU7tQFZ+xlkevvdTxo7yu/ImNzY5OMnnz0icZ2rDWMFE/+8+gv+vFq
         Z6fw==
X-Gm-Message-State: ACgBeo0JiU75rvRgxWltz+Mclx7a4bJOqMbhekk783DYP061Q9waQgEQ
        BjgfGUoOCZQ1pS+aXNsNkhxO6e6828Q=
X-Google-Smtp-Source: AA6agR6IrmB7o1dJYmEqimDXo+pJZhJG8aBOsL/qWmizDHRTMQ2R5IXz0YJgYMy3pvZF1sGtVuUiWg==
X-Received: by 2002:a17:90a:bb81:b0:1f8:ba92:9fc0 with SMTP id v1-20020a17090abb8100b001f8ba929fc0mr18848987pjr.243.1660567956795;
        Mon, 15 Aug 2022 05:52:36 -0700 (PDT)
Received: from localhost ([223.167.97.46])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902654600b0016c68b56be7sm6894573pln.158.2022.08.15.05.52.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Aug 2022 05:52:36 -0700 (PDT)
From:   JunChao Sun <sunjunchao2870@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     tytso@mit.edu, corbet@lwn.net, bagasdotme@gmail.com,
        JunChao Sun <sunjunchao2870@gmail.com>
Subject: [PATCH] Documentation: ext4: correct the document about superblock
Date:   Mon, 15 Aug 2022 05:52:33 -0700
Message-Id: <20220815125233.2040-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The description of s_lastcheck_hi, s_first_error_time_hi, and
s_last_error_time_hi fields refer to themselves, while these means
referring to upper 8 bits (byte) of corresponding fields (s_lastcheck,
s_first_error_time, and s_last_error_time). Correct the mistake.

Signed-off-by: JunChao Sun <sunjunchao2870@gmail.com>
---
 Documentation/filesystems/ext4/super.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/ext4/super.rst b/Documentation/filesystems/ext4/super.rst
index 268888522e35..0152888cac29 100644
--- a/Documentation/filesystems/ext4/super.rst
+++ b/Documentation/filesystems/ext4/super.rst
@@ -456,15 +456,15 @@ The ext4 superblock is laid out as follows in
    * - 0x277
      - __u8
      - s_lastcheck_hi
-     - Upper 8 bits of the s_lastcheck_hi field.
+     - Upper 8 bits of the s_lastcheck field.
    * - 0x278
      - __u8
      - s_first_error_time_hi
-     - Upper 8 bits of the s_first_error_time_hi field.
+     - Upper 8 bits of the s_first_error_time field.
    * - 0x279
      - __u8
      - s_last_error_time_hi
-     - Upper 8 bits of the s_last_error_time_hi field.
+     - Upper 8 bits of the s_last_error_time field.
    * - 0x27A
      - __u8
      - s_pad[2]
-- 
2.17.1

