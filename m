Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988607B0338
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Sep 2023 13:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjI0LjR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Sep 2023 07:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjI0LjQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Sep 2023 07:39:16 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7E3F3;
        Wed, 27 Sep 2023 04:39:16 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6910ea9cca1so8426336b3a.1;
        Wed, 27 Sep 2023 04:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695814755; x=1696419555; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qms51CQ2WQSXHU/5tuuz4JkW0EAA9NoxeleH7bPZoRI=;
        b=O/D+AAPhB957RPQgl+xQwAMs+t3+VqsEjMkN+eXVmZf3D8/OwgT90IrMmpo9IsVklp
         suabVKna7i9b5S/MKMrgCn6GdUMKSxRupw8hzEjyX8tmHkosOfAMPLT41eE4Nc6+BEjF
         0+7MVBL2fClIeKj9ePuTQ4u+89Gprp/hM5RDWBvMx0A/vOWQq97ja4l7vKHgC+gNWYkr
         e/Mzixg/E23HRcUIrWq69Disytrv9GaiVkxykGOwdcy/iq1QrS60W+0PTt6aqEZoWCoc
         yFwsaIuKFaIMIP4KROmf7aADzNGGLuHWiLWVKzZQQZQqruDYanmT2vtL6j75esbcOsLw
         ExBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695814755; x=1696419555;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qms51CQ2WQSXHU/5tuuz4JkW0EAA9NoxeleH7bPZoRI=;
        b=Cxhzi/IGz59F0P41ZgThPF2RiQyo+MzP4HS1ZNoeyC5zj97logyyyH2PxwvjJcIdwu
         ZFVq2qWUl0fAWIYnZ7sfNEPAUlNxmnwHqUuWo0H+nZ6ZLukbX0k9O56qgtTHL/XCWDNH
         rZECRQ403pY92PB+q67SzTrjLdw0AySIadmj5hKzZMp2kaRNd4hbLG1rqVdNBTN3EHz2
         c3LkjtTHDafLfLTXdOgk8vAzRVhAdatheJnIFIC4/SMpG3zQBo8HwITQ+g1b+OywkJ7X
         rjDFy+5mcp2Tzaqdk2Y4R/UlKnBMWze4Kz2XmYcrKd7judWJQb7QgbEyn+mLuoDzPEtO
         J/IQ==
X-Gm-Message-State: AOJu0Yxc7Rp1vPk4hEFboaKMnIrNXGSDg5DRL3yHosGDhVM5cm2wD7DI
        iMVfpbmP3e7UbulvqmDB+9Kk/BrUi+U=
X-Google-Smtp-Source: AGHT+IEBOY2HOlEm/QyiAFW2DeIbaY8QW2fLElGZ4O7aWhYkkfUWiYhyo9C7oLvo5g40d3+7TD6z+A==
X-Received: by 2002:a05:6a21:66cb:b0:15e:9e62:7082 with SMTP id ze11-20020a056a2166cb00b0015e9e627082mr1395953pzb.29.1695814754695;
        Wed, 27 Sep 2023 04:39:14 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090a518400b00268dac826d4sm12727592pjh.0.2023.09.27.04.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 04:39:14 -0700 (PDT)
Date:   Wed, 27 Sep 2023 17:09:10 +0530
Message-Id: <87cyy3g80x.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 11/12] ext4: add first unit test for ext4_mb_new_blocks_simple in mballoc
In-Reply-To: <20230919201532.310085-12-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kemeng Shi <shikemeng@huaweicloud.com> writes:

> Here are prepared work:
> 1. Include mballoc-test.c to mballoc.c to be able test static function
> in mballoc.c.
> 2. Implement static stub to avoid read IO to disk.
> 3. Construct fake super_block. Only partial members are set, more members
> will be set when more functions are tested.
> Then unit test for ext4_mb_new_blocks_simple is added.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc-test.c | 325 +++++++++++++++++++++++++++++++++++++++++
>  fs/ext4/mballoc.c      |   4 +
>  2 files changed, 329 insertions(+)
>  create mode 100644 fs/ext4/mballoc-test.c

I guess I missed to add by RB in previous revision. I see there are no
functional changes to this patch from previous revision. 

Please feel free to add - 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks!
-ritesh
