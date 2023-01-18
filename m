Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE605672287
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jan 2023 17:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjARQIN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Jan 2023 11:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjARQHs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Jan 2023 11:07:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF4454124
        for <linux-ext4@vger.kernel.org>; Wed, 18 Jan 2023 08:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674057818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k6IqmmpZ9I4Vl93/dhw5LrxVGVOKyZqjXYxYco0sdHY=;
        b=c3QQ3gMtrp6mWhWZ5ppNZLy1YNUuUC/ETn/6RHKMLu8dtHT5botz91hbsLjMG6pqnlsV0o
        BjImmnUpRDkdOqFTPj8uHdXFAjvcocWXvISEyZpjZFfFr4BKBVmW5L3pvJt1ho82ml4VMf
        02q35mTQfv0YgEHOfWuETxcWHazSgAc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-626-lpUOXgtGMmSfP1Ol9axIAg-1; Wed, 18 Jan 2023 11:03:35 -0500
X-MC-Unique: lpUOXgtGMmSfP1Ol9axIAg-1
Received: by mail-pf1-f199.google.com with SMTP id cw8-20020a056a00450800b0058a3508303eso12212449pfb.13
        for <linux-ext4@vger.kernel.org>; Wed, 18 Jan 2023 08:03:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6IqmmpZ9I4Vl93/dhw5LrxVGVOKyZqjXYxYco0sdHY=;
        b=POZICwiobgoVBjxEBntqvKFjAt2RrWVFuu+IcRwKyyJ5Ur/qJWdoU8NFSaU5tlEPa0
         g44tN8JV6GEklIu+gxau1vWiLtTPpWqp8W+x1d8HLgQ+ZnAMvOvICeSjoZTaacXiAxEI
         25FUVvCbHMg0jKQ77F5S7y1CI2MiPWjylhKl68FfJhBLNB4DHP4h45XUWFR8smAXj3SN
         dQj6fZ2xrXNkLYfNh+0qabLNZ4YdSvcJ8r0ADAComGbNFT4L3VXSZL6wzeFw/GVugjz9
         IrQKvL4KYeKisBU9CzOtXC3lSa42K4NgChr/RCfcLZvBrFodYg96sIDjVIgOJ4zseWQU
         wvWg==
X-Gm-Message-State: AFqh2kpaM7qmetrjFG+IfKQGH5fInP5y+JZHEVOSdY5oJFXtosATbdS7
        nEWYCtdzX1hcxP3cCBd09u+3vLAjs2XZ+4v6JtceJkjK1uUJxZeDT3x8DsTNu81bGdYdXkSfwnW
        n6VysSyxLyOm6THBPtNVWug==
X-Received: by 2002:a05:6a00:4c85:b0:58d:dfb1:8023 with SMTP id eb5-20020a056a004c8500b0058ddfb18023mr5001063pfb.15.1674057813891;
        Wed, 18 Jan 2023 08:03:33 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs471cXGsAqsTBhZmYbNrPuvtIJQ9qUHn3BExn6sNE+TJfwyf6NmyB9vzFYeYsjUo7hyWa/bQ==
X-Received: by 2002:a05:6a00:4c85:b0:58d:dfb1:8023 with SMTP id eb5-20020a056a004c8500b0058ddfb18023mr5001043pfb.15.1674057813641;
        Wed, 18 Jan 2023 08:03:33 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w4-20020aa79544000000b0058db5d4b391sm5307916pfq.19.2023.01.18.08.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:03:33 -0800 (PST)
Date:   Thu, 19 Jan 2023 00:03:28 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "wangjianjian (C)" <wangjianjian3@huawei.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Add default commit interval test
Message-ID: <20230118160328.qusc5f7h6iwy6tbj@zlang-mailbox>
References: <20230118052515.3966391-1-wangjianjian3@huawei.com>
 <f6b28fd3-1f36-2bb0-aadd-d08b81a64835@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6b28fd3-1f36-2bb0-aadd-d08b81a64835@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 18, 2023 at 01:27:05PM +0800, wangjianjian (C) wrote:
> Ignore, sorry for the traffic...

Do you mean ignore those redundant patches, or ignore this change itself?

> 

