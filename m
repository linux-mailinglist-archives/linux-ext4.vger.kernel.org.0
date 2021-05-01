Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5EF37068E
	for <lists+linux-ext4@lfdr.de>; Sat,  1 May 2021 11:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhEAJS6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 1 May 2021 05:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhEAJS5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 1 May 2021 05:18:57 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D5AC06174A
        for <linux-ext4@vger.kernel.org>; Sat,  1 May 2021 02:18:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x5so401586wrv.13
        for <linux-ext4@vger.kernel.org>; Sat, 01 May 2021 02:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=cxHTQEn4CMsRRZJNaIEpfxdSAuaxYGXto5pLQbQufGE=;
        b=vRHw82Kea5MncNLB92TKVEk058YJGRACCYsueHhoVPboSQJwaQrPGnbUyEa7ySlQgG
         GbchnOKmlRV98YaL89NPDkKGerG9SvfgvSLBSb7a5uq65evQTYQW0HC97lbFxVAXLqgM
         LoGfGbN85f9/NcTBk4buae24uzmTNGS7xHOSJZeVnreYaxgOcodpipFAqY05kKfVHjk3
         9v+aH4dPiorXt+R6hFgda8ZkanxdgYjDBGzHn+zQ8dk0mjIzIVzck0IAumOjIP+8g07D
         w0nhKmQjkfSc8U1iOuuVh0R+UWcqMF/vuN0XwUnEc8oMOJ9U7MeY/WBIu8TGAjplbRy1
         hwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=cxHTQEn4CMsRRZJNaIEpfxdSAuaxYGXto5pLQbQufGE=;
        b=fLZET2j+WIsGPdo1WIo1H9nfmWRLrH9mf344ru2KPScNUd4N+kgeavrHUa1S5SgHFf
         FqfAJtH9JJJIZopQr1RBJ5+RSPYvGKHLQ3SpAispRTb6lUNKpxAEjqShLDKCXDSWt7EH
         3QtHHzCzzpPxpCpb5E0NhOuZQRwNZ0hipEqE47o+YzLom8p6N71aZl6CFQsbV1MtlLqI
         fs5TU3reb5p4K7/9b+G17xpQLdtxUrxxWrpp280XFDyqfEUNDQgCoMSimI94mMXtcqT6
         HP0b+bbBc4mCZUjS6tHvXhYRY3/Go0T95bPWosZpZv6iuYUaNQrNzXvbNifBw++6i/KB
         lOTg==
X-Gm-Message-State: AOAM533oIPPw4xn0lVnmteJRym6LAY2voRGxPtNBbmpfhy9pTe1gvCy7
        m2ddcTDk38EY5ip3zg28cpglXiodTH6zLXO5YO3Ucw==
X-Google-Smtp-Source: ABdhPJyx+Zk3GjYruvL28LxuKpwgcHeMfokdODi8yIgFZ9W9ZAy/D0ULBvGdKXqhAL+0/HVpORKHTQ==
X-Received: by 2002:a5d:4a87:: with SMTP id o7mr13092536wrq.102.1619860686837;
        Sat, 01 May 2021 02:18:06 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id g11sm4898095wri.59.2021.05.01.02.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 02:18:06 -0700 (PDT)
Date:   Sat, 1 May 2021 10:18:04 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca, linux-kernel@vger.kernel.org,
        tytso@mit.edu
Subject: Re: [PATCH] fs: ext4: mballoc: amend goto to cleanup groupinfo
 memory correctly
Message-ID: <YI0czH0auvWlU8bA@equinox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412073837.1686-1-phil@philpotter.co.uk>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi All,

Sorry to be pushy (I know everyone is busy) but I've had no feedback on
this patch yet:
https://lore.kernel.org/linux-ext4/20210412073837.1686-1-phil@philpotter.co.uk/T/#u

Could I please ask for it to be reviewed? Many thanks.

Regards,
Phil Potter
