Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAF26FB619
	for <lists+linux-ext4@lfdr.de>; Mon,  8 May 2023 19:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjEHRvS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 May 2023 13:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjEHRvR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 May 2023 13:51:17 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE41044A0
        for <linux-ext4@vger.kernel.org>; Mon,  8 May 2023 10:51:16 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-643846c006fso5156399b3a.0
        for <linux-ext4@vger.kernel.org>; Mon, 08 May 2023 10:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683568276; x=1686160276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VafRcudYIB+Vss0WviCwV8NofZWUWxagaBIfp0lm4Xg=;
        b=MVvBoUj+VREvhlPQsIh+KA6acXVbp/HF6AqLrfN/BuY9jt4ubR7gG6IATdPBpfk0g/
         k2KMY8/tsU4zklANHFkewsCVlix1kP9tlOCT9F+N4MD7VL1nzPB3hDSfkfCAcyksNo7X
         9Vcrag49A3+J+sGzb2rtWpEsI1QJ39g+lHeLqO5uiSY6kjk23LpxKGMJMyUru31dqs5k
         aN3pc4xJso4Pk6ZbYRXBgVxcrAUn8cwF1tYzINpaSaA72MlEi8nxkG9wAogSqP0MTifb
         O9B2rgDCOpbKj7eDh1HCrJez6iSBqQAlW5bzOWh9ZMAexGx2KkPPqfWroRcEyhVoaF4y
         AJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683568276; x=1686160276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VafRcudYIB+Vss0WviCwV8NofZWUWxagaBIfp0lm4Xg=;
        b=FnxrbQQkSuWM9GIOX50qq5Ohd76KWphOuHfAKaPNf2TgTYKO57d4FMyWUE9jCmYFRV
         wzMciMPw3AX3DRm5ykLUFUJMf+oi0Rg364+2pR/sbIRhRILvm3nPvvcQEGeAKfa69m+/
         HsR0QU+Qvjz+VTP6FtNp5/vHoF1mDKntenBTm30dNOtf0D8VSUjX1eA3cNAnq1xdc87j
         F3ew8WU0YM72Ls7ZoIUbCR8zVNezMgl8g4gRQlkEE9nub4xLwOPkbwQX/KU/B8FX15dD
         GvTgH1yQwHJd/0tHg/pw2THKfS+wVMgZZeet5QWwUQeNktpY7LfsdGUws8kL9pf/jTId
         fPzw==
X-Gm-Message-State: AC+VfDwHoLySLou73n9/vUPw53NWMw13OzRu+iJ8Z25EUXkzLihH8M2R
        QPMJTJYJL2BYy+5+6x8pnEA=
X-Google-Smtp-Source: ACHHUZ6qLNciLWXUpTN47N/IknRHSontPkasdyLEy+xKCIKc7YIPoOaOieDWr8jWjlbACZwUEbIhBg==
X-Received: by 2002:a05:6a00:168b:b0:63d:2d7d:b6f2 with SMTP id k11-20020a056a00168b00b0063d2d7db6f2mr15830838pfc.4.1683568276132;
        Mon, 08 May 2023 10:51:16 -0700 (PDT)
Received: from localhost.localdomain (ec2-43-207-231-123.ap-northeast-1.compute.amazonaws.com. [43.207.231.123])
        by smtp.gmail.com with ESMTPSA id c4-20020aa781c4000000b006413bf90e72sm263676pfn.62.2023.05.08.10.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:51:15 -0700 (PDT)
From:   youling257 <youling257@gmail.com>
To:     jack@suse.cz
Cc:     hch@infradead.org, hch@lst.de, linux-ext4@vger.kernel.org,
        ritesh.list@gmail.com, tytso@mit.edu
Subject: [PATCH v4 12/13] ext4: Stop providing .writepage hook
Date:   Tue,  9 May 2023 01:51:08 +0800
Message-Id: <20230508175108.6986-1-youling257@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20221207112722.22220-12-jack@suse.cz>
References: <20221207112722.22220-12-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I using linux mainline kernel on android. https://github.com/youling257/android-mainline/commits/6.4  https://github.com/youling257/android-mainline/commits/6.3
"ext4: Stop providing .writepage hook" cause some android app unable to read storage/emulated/0 files, i need to say android esdfs file system storage/emulated is ext4 data/media bind mount.
I want to ask, why android storage/emulated need .writepage hook?
