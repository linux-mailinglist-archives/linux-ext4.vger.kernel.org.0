Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A7A581A11
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Jul 2022 21:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiGZTFL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Jul 2022 15:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239738AbiGZTFK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Jul 2022 15:05:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0046FC4B;
        Tue, 26 Jul 2022 12:05:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA4C3B819C5;
        Tue, 26 Jul 2022 19:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7469C433C1;
        Tue, 26 Jul 2022 19:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1658862306;
        bh=8HO1+0RNEW20BOdzYYpK3e0czzp1ctqmJl8m1mL5930=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jtWtbCvK3nAkuqT2HuiCQ7VGsG6UUqOPsV6eZjfDx6mo6ENgUYGB52rsb2vBlQWwz
         w2cz8xupjrK9I0ISykF/uaB+onTvwra4lMAK6ilCsMeHDnXFebfJemPcSOKKQIAeVv
         eDoEcuJScyoa0uvCKR+qZSe8ejnDGj1gw5J79dF0=
Date:   Tue, 26 Jul 2022 12:05:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>
Cc:     David Hildenbrand <david@redhat.com>, jgg@nvidia.com,
        Felix.Kuehling@amd.com, linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org
Subject: Re: [PATCH v9 06/14] mm/gup: migrate device coherent pages when
 pinning instead of failing
Message-Id: <20220726120504.39498eff3843baf1d8fd5168@linux-foundation.org>
In-Reply-To: <adb2031b-774d-e645-2aec-f9de433b0a7c@amd.com>
References: <20220715150521.18165-1-alex.sierra@amd.com>
        <20220715150521.18165-7-alex.sierra@amd.com>
        <225554c2-9174-555e-ddc0-df95c39211bc@redhat.com>
        <20220718133235.4fdbd6ec303219e5a3ba49cf@linux-foundation.org>
        <adb2031b-774d-e645-2aec-f9de433b0a7c@amd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 25 Jul 2022 21:22:06 -0500 "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com> wrote:

> >> a) add the || to the end of the previous line
> >> b) indent such the we have a nice-to-read alignment
> >>
> >> if (!list_empty(&movable_page_list) || isolation_error_count ||
> >>      coherent_pages)
> >>
> > I missed that.  This series is now in mm-stable so any fix will need to
> > be a standalone followup patch, please.
> Hi Andrew,
> Just wanted to make sure nothing is missing from our side to merge this 
> patch series.

It's queued in mm-stable and all looks good for a 5.20-rc1 merge.
