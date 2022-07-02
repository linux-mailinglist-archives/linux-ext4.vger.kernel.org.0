Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BE4563E69
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Jul 2022 06:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiGBEZy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 2 Jul 2022 00:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiGBEZy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 2 Jul 2022 00:25:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382AB35DE0;
        Fri,  1 Jul 2022 21:25:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6DC260A1B;
        Sat,  2 Jul 2022 04:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C8EC34114;
        Sat,  2 Jul 2022 04:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1656735952;
        bh=CnLxEWfEVwpNoTxWsiwQ1LQuKst+72BKDbjbXAesDa4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LQCMYCHDQR6Snh03VJXykPrYGM58AdpZzxwBcPzIoKS+eBA9CKb8Ndukm4D2HfPUa
         i4yAErDdhscv7vlgetKrJZ7oiJZp8dU98i+LE/12HMErHBMVVau0tOR8gyM7ntkFIH
         yJLFkEd0F9svS2uuJzXBntMgT6QOg+GCbOO/3Vn8=
Date:   Fri, 1 Jul 2022 21:25:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Felix Kuehling <felix.kuehling@amd.com>,
        Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org
Subject: Re: [PATCH v7 01/14] mm: rename is_pinnable_pages to
 is_pinnable_longterm_pages
Message-Id: <20220701212551.7198162dbd65746a69bc41b4@linux-foundation.org>
In-Reply-To: <49315889-96de-8e41-f8ee-dd5b33c5e1db@redhat.com>
References: <20220629035426.20013-1-alex.sierra@amd.com>
        <20220629035426.20013-2-alex.sierra@amd.com>
        <f00f9c93-c115-d222-dc8c-11493ccd2567@redhat.com>
        <575b48a6-e372-acda-9a7c-449f307a588c@amd.com>
        <49315889-96de-8e41-f8ee-dd5b33c5e1db@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 30 Jun 2022 00:15:06 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 30.06.22 00:08, Felix Kuehling wrote:
> > On 2022-06-29 03:33, David Hildenbrand wrote:
> >> On 29.06.22 05:54, Alex Sierra wrote:
> >>> is_pinnable_page() and folio_is_pinnable() were renamed to
> >>> is_longterm_pinnable_page() and folio_is_longterm_pinnable()
> >>> respectively. These functions are used in the FOLL_LONGTERM flag
> >>> context.
> >> Subject talks about "*_pages"
> >>
> >>
> >> Can you elaborate why the move from mm.h to memremap.h is justified?
> > 
> > Patch 2 adds is_device_coherent_page in memremap.h and updates 
> > is_longterm_pinnable_page to call is_device_coherent_page. memremap.h 
> > cannot include mm.h because it is itself included by mm.h. So the choice 
> > was to move is_longterm_pinnable_page to memremap.h, or move 
> > is_device_coherent_page and all its dependencies to mm.h. The latter 
> > would have been a bigger change.
> 
> I really don't think something mm generic that compiles without
> ZONE_DEVICE belongs into memremap.h. Please find a cleaner way to get
> this done.

(without having bothered to look at the code...)

The solution is always to create a new purpose-specific header file.
