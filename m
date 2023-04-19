Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134E96E7371
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Apr 2023 08:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjDSGq0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Apr 2023 02:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjDSGqZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 Apr 2023 02:46:25 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD4B4C20
        for <linux-ext4@vger.kernel.org>; Tue, 18 Apr 2023 23:46:23 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2a8dc00ade2so9709421fa.0
        for <linux-ext4@vger.kernel.org>; Tue, 18 Apr 2023 23:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681886782; x=1684478782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=REFDeFFHoGYAMs7mXmFQo05Mywd2wMBmW68DbUZdoEA=;
        b=gVmp6A2LDZo9NDmz1uDoJ4drOkmrxw2o3UHLvKf/cgd0ceOIRpxRC1jEo97XCZ8g6C
         DllOfslF1rujtNJPOLfMRy8vmP2+4leUWug3yUnAjEVZRxInlYg8un39MJp3Ze+PZ1Sm
         o6R/5c09BOPOlRdNM+0+oi9ACbSjKVN5TKseizkDooAhBOnh6b9rm5aqx603dtnOd6HG
         EB3OTImqLHOhihj81uuAhZxLZw++Onttm59nXp4b6WVNqYCm2JnvQwC4V5CSQNXI7wbV
         R5Ja7g3HtZf3kmfcq5jBbZ/acPSssHZtuNw3M976JObSGr0Sh/G6vjuKDi+BKtZE84vN
         Edsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681886782; x=1684478782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=REFDeFFHoGYAMs7mXmFQo05Mywd2wMBmW68DbUZdoEA=;
        b=YlWRcVSkHU2Ze99O07sAieB2NxLyMk4tWq2o9iouknrPL2EuEvG8i4c4xhHt4fhAnr
         yvrsodcGSQ+bHrKYNWXeM5he5uWNwf93Lejf/mzIBhd1/aoleK6vb8FoyHhjhfNJFide
         J/8BzJ6S0Z6zDwPoSDc1IH2UFiAIys1co0duuDJpWhj/BjdbBfgeMLWkBh9WfVeSKVZ+
         3YGXbRfAtz0/sQTE1Mf1uBT0OEVxOSYLrR5zNWWWXx6ZLZGysH7xWlxHe5llXmR0EDJq
         Cy3+oX9ge32WLHaVTRfY+J3jcDDiPA6YoTZKAXVBxI+6jwgq/D/wbzXoq6Rm2OKn4h4K
         TJ5A==
X-Gm-Message-State: AAQBX9cYaR7roURf2n8j5sKXrT4hIvx87bbjdO1cMaKxNdoDb2BhFJL3
        ZrIi+dSGJGiBcC5Jfcm1VZljHT7UTP37yT8Xpw/fBg==
X-Google-Smtp-Source: AKy350aD5eVr42g4rwqGrk2SydA231Wzv8flZqooGRthYtYxasSLbRiVZ17XIxAeRYYejoZ1eUVwPQ==
X-Received: by 2002:ac2:46c3:0:b0:4dc:6ad4:5fe4 with SMTP id p3-20020ac246c3000000b004dc6ad45fe4mr3697959lfo.32.1681886782056;
        Tue, 18 Apr 2023 23:46:22 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id e24-20020ac25478000000b004edce1d338csm438208lfn.89.2023.04.18.23.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 23:46:19 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     stable@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        joneslee@google.com, Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH][for stable [4.14, 5.10] 0/3] ext4: fix use-after-free in ext4_xattr_set_entry
Date:   Wed, 19 Apr 2023 06:46:07 +0000
Message-ID: <20230419064610.1918038-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is a good example that emphasizes that the order in which patches
are queued to stable matters. More details in the revert commit.
Tested and intended for 4.14, 4.19, 5.4, 5.10.

Baokun Li (1):
  ext4: fix use-after-free in ext4_xattr_set_entry

Ritesh Harjani (1):
  ext4: remove duplicate definition of ext4_xattr_ibody_inline_set()

Tudor Ambarus (1):
  Revert "ext4: fix use-after-free in ext4_xattr_set_entry"

 fs/ext4/inline.c | 11 +++++------
 fs/ext4/xattr.c  | 26 +-------------------------
 fs/ext4/xattr.h  |  6 +++---
 3 files changed, 9 insertions(+), 34 deletions(-)

-- 
2.40.0.634.g4ca3ef3211-goog

