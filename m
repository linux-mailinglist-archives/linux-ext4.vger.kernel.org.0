Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5323C54EF2E
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jun 2022 04:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbiFQCTb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Jun 2022 22:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiFQCTa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Jun 2022 22:19:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE88F606E1;
        Thu, 16 Jun 2022 19:19:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A09261C50;
        Fri, 17 Jun 2022 02:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B77C3411A;
        Fri, 17 Jun 2022 02:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655432368;
        bh=Yki0vBzHWKtp6dJbGwH7gUmRk173I5HAJLFYlBbmLtI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U9nPBXKmGgZZ77OA8gwHRrq5HaWuWMnXvA4xx6OL7Qe5Q6WWAkLhRNj5c2JUuTOqP
         fC5Sfz1KP6igFDmHzTkyDdxVCfXz+BEUxESyFl0RvL9jo3cHVy1jIy83e+BVWZ/Bg5
         Ri0ktWlcrRmiQmPMePGTfamFHNmIEHqZQXsclOsA=
Date:   Thu, 16 Jun 2022 19:19:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alex Sierra <alex.sierra@amd.com>
Cc:     <jgg@nvidia.com>, <david@redhat.com>, <Felix.Kuehling@amd.com>,
        <linux-mm@kvack.org>, <rcampbell@nvidia.com>,
        <linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <hch@lst.de>, <jglisse@redhat.com>, <apopple@nvidia.com>,
        <willy@infradead.org>
Subject: Re: [PATCH v5 00/13] Add MEMORY_DEVICE_COHERENT for coherent device
 memory mapping
Message-Id: <20220616191927.b4500e2f73500b9241009788@linux-foundation.org>
In-Reply-To: <20220531200041.24904-1-alex.sierra@amd.com>
References: <20220531200041.24904-1-alex.sierra@amd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 31 May 2022 15:00:28 -0500 Alex Sierra <alex.sierra@amd.com> wrote:

> This is our MEMORY_DEVICE_COHERENT patch series rebased and updated
> for current 5.18.0

I plan to move this series into the non-rebasing mm-stable branch in a
few days.  Unless sternly told not to do so!
