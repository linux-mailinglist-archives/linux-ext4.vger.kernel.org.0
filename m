Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A701772DC87
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jun 2023 10:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241234AbjFMIcH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jun 2023 04:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241263AbjFMIcG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jun 2023 04:32:06 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7082E188
        for <linux-ext4@vger.kernel.org>; Tue, 13 Jun 2023 01:31:59 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b3c0c476d1so19990985ad.1
        for <linux-ext4@vger.kernel.org>; Tue, 13 Jun 2023 01:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686645118; x=1689237118;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fAWSkGYmCWKL5bXYvk6CuiJFkQfPXw1vMINiicyg49U=;
        b=L3JDIHCQLc/kKPQ7RVpu8TO+yLZtzIb+z4Lsb/I1AMVjDhghGweWBGqEyf4rENg0iN
         nMun24JAlxBaDIJmkyOoIvBpDQUgUWSF/kD/D6SQrkLn23tALsz/SOZJBRmeZ1qFGfjc
         xODY3EsrD3BavVKhTODyXuoQYwqUNYnjACl07UcSnVJoInE4lTMSlhQP6xVQoaW/qEpm
         QQQeg24YsBFXKWy8emfuIdsV+9tzl95SIqJDeiZUtae3AWWi6Z3JHOxN0yCm/s+jUW+X
         Jb5fACuGXHJg0cp0KOF3n0b7JJHR4y9NkYp/bvMNcqsKS5+b+C2KYgAd6gxxTIF/VXOf
         aMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686645118; x=1689237118;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fAWSkGYmCWKL5bXYvk6CuiJFkQfPXw1vMINiicyg49U=;
        b=Jw4qgvy4Moa09W1IRcc/KKsqhP4bw67mUVmOw0EVXTrgQ8qqFl7fVlSeDrc/CZYjVC
         +Z1tGHf+zv5s+B6RRF0TeTYpVq55zRpMVUU1NKo8xB9T2g2SwxA7aZ9gFJVdDqU3qqa/
         xV+mLbJY0v7iMAdP07FMiTt/dDIecuTKEmu6U2wsGSqEXTn2fHtin6pWhbtfkuVPgmvR
         inb/8oWLYAYoux3ZC69r+1ZQZrgkuv0UdCbfvW5Eirs7Oa5Wv3a+Qf7N0vG/BWsQBGpb
         nyseUWuf4DspnDsSdXKkXbY2a5OyeRQLgi+ygWJen74n24JnD+KMaNa+tmtOOV1AaaTe
         ivIQ==
X-Gm-Message-State: AC+VfDzMAdJnXZt3dPNupuSaL/yNSMLy6cJN1wHJqt6+I2jULkMEfWVF
        hvK9fS8jBgxUKTJnLn3GtHHCfnSe/YI=
X-Google-Smtp-Source: ACHHUZ5GhjAb2nQsY9imH9PlskIZGrkImeP7O5SouKtoTau4bmv/MtOsJLctmWKziDbS6JTfZaXdMQ==
X-Received: by 2002:a17:902:8544:b0:1b3:7def:3754 with SMTP id d4-20020a170902854400b001b37def3754mr8645186plo.28.1686645118473;
        Tue, 13 Jun 2023 01:31:58 -0700 (PDT)
Received: from dw-tp ([129.41.58.19])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902da8300b001ab01598f40sm9589295plx.173.2023.06.13.01.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 01:31:57 -0700 (PDT)
Date:   Tue, 13 Jun 2023 19:27:23 +0530
Message-Id: <87ttvb5ut8.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christoph Hellwig <hch@lst.de>, tytso@mit.edu,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: set FMODE_CAN_ODIRECT instead of a dummy direct_IO method
In-Reply-To: <20230613054700.GA14648@lst.de>
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> On Tue, Jun 13, 2023 at 11:00:19AM +0530, Ritesh Harjani wrote:
>> why do we require .direct_IO function op for any of the dax_aops?
>> IIUC, any inode if it supports DAX i.e. IS_DAX(inode), then it takes the
>> separate path in file read/write iter path.
>>
>> so it should never do ->direct_IO on an inode which supports DAX right?
>
> do_dentry_open rejects opens with O_DIRECT if FMODE_CAN_ODIRECT is
> not set.  So we either needs to set that manually or because there is a
> ->direct_IO if we want to keep supporting O_DIRECT opens for DAX
> files, which we've traditionally supported.

Ok, so for DAX it was mainly to support file opens with O_DIRECT semantics.

Thanks
-ritesh
