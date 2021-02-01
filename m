Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B03230AC73
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Feb 2021 17:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhBAQQ0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Feb 2021 11:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhBAQQX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Feb 2021 11:16:23 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C2FC061573;
        Mon,  1 Feb 2021 08:15:42 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l12so17226192wry.2;
        Mon, 01 Feb 2021 08:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZDuWWmP/CpWd2/GjAQP26lhvef68ZdIbhiH4GoBTIfE=;
        b=jd50eoQHbsQcPcTxaK3cAhpIqB485plyJpijNhsDjTnWsc952jplkEXh9ZURAfk5xQ
         2NbazQG9OHsAs/U0T94mCtEph4kFWIwm+dQxCIG9Ho6zNRDTb0fP3fPDY4V69yL8GqoO
         ZiSGmn/HQ6D0z81GjK3tlYJSNp28buzgrV3kxBHebtJm6jtKly4dfFfFizpnDKoykNFh
         ptQ316QfeDh8kGmhwWgu1dMBG34BfrVHarT1iIjS+c8MC9sm+a73iza0yoo69fLQG2A5
         8SIRzMUv50Grpy3rvacpo9yuXcKmYzYGBkLUdqkjVESbBH7dZ4EkYn0imfabNZGniKUE
         41SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZDuWWmP/CpWd2/GjAQP26lhvef68ZdIbhiH4GoBTIfE=;
        b=aMeRjfRm0Riy/CqoyzTnVzF5VStcXoXzM7rS0zEd3U/sWE9X/l1IytLwS4sOtuV3vd
         5ivLxRt/AF5sQpnU8GpFz4c+JKL5aP5hshD6TGHJDCJf7jxi/sQ8MmSbdrq32O6oUI2G
         ox9KdlwFJS9HVcjKA9qZ/YyHt53Qbck6PoMOf2IBpuOX9Pv7FWd4AbCvJk/O+pfFwXdp
         AnNPmRhKEUKFiWkRI0oX6G4wzau4tHgU/8kiH0QYgmV3bQjk7ZhM9tbiqa83AZjyZXyX
         yjhpyTWuuCj7kTpCzZzyN9p6VOLGe2PLxwKvvgkThr1CAK8VneSyB97BXv0vGBRqt9Wb
         9WEQ==
X-Gm-Message-State: AOAM533CLf9kx7QoupBhcKy51FEiRMOg6ok2rtjI+SoO8P2nNZEOrcw4
        vbjXeE1cXlKa88VNlADSppvlHCWGloJo3L/ab/o=
X-Google-Smtp-Source: ABdhPJwNkGXVFvEICEQjWInJttb7yzXTMJVgFudoMoTE86a1oXks7IIzTY/n8soSger7QYJ7nteq2qaBtbFi5sk+LFU=
X-Received: by 2002:a5d:69ce:: with SMTP id s14mr18382220wrw.206.1612196140971;
 Mon, 01 Feb 2021 08:15:40 -0800 (PST)
MIME-Version: 1.0
References: <AAB32610-D238-4137-96DE-33655AAAB545@dilger.ca>
 <20210201003125.90257-1-viniciustinti@gmail.com> <20210201124924.GA3284018@infradead.org>
In-Reply-To: <20210201124924.GA3284018@infradead.org>
From:   Vinicius Tinti <viniciustinti@gmail.com>
Date:   Mon, 1 Feb 2021 13:15:29 -0300
Message-ID: <CALD9WKxc0kMPCHSoikko+qYk2+ZLUy73+ryKGW9qMSpyzAobLA@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: Enable code path when DX_DEBUG is set
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 1, 2021 at 9:49 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> DX_DEBUG is completely dead code, so either kill it off or make it an
> actual CONFIG_* symbol through Kconfig if it seems useful.

About the unreachable code in "if (0)" I think it could be removed.
It seems to be doing an extra check.

About the DX_DEBUG I think I can do another patch adding it to Kconfig
as you and Nathan suggested.

What do you think?
