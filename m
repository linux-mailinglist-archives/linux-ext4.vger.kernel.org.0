Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9C849F409
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jan 2022 08:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242660AbiA1HIt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Jan 2022 02:08:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40846 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238217AbiA1HIt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Jan 2022 02:08:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5C2161B4E;
        Fri, 28 Jan 2022 07:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EDFC340E0;
        Fri, 28 Jan 2022 07:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1643353728;
        bh=RwoGhw9V3nvnXM6f38F+V1PStwHO0x+5RXTTdAXp7JY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jsz1QO9E0ZfOdT9FgvWsZdDnsyje3cBIe9Sp+qpxxX4U4KTlhRY9LrCn0XUx3HaZP
         4WBX+6yG1a3ICbZ89FPVGOwdGh7lyOhl74FamB4CNioDPaMo5s1LstXIHuob98PHkc
         WBP4cFU5GkOpnhCpCtQ/L8gGFP+Xn6e+p2yM+w34=
Date:   Thu, 27 Jan 2022 23:08:45 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>
Cc:     Felix.Kuehling@amd.com, linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jgg@nvidia.com, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH v4 00/10] Add MEMORY_DEVICE_COHERENT for coherent device
 memory mapping
Message-Id: <20220127230845.13a11680077ca5d4334de8f3@linux-foundation.org>
In-Reply-To: <6434ba24-a219-6a5a-d902-0b48974a0e43@amd.com>
References: <20220127030949.19396-1-alex.sierra@amd.com>
        <20220127143258.8da663659948ad1e6f0c0ea8@linux-foundation.org>
        <6434ba24-a219-6a5a-d902-0b48974a0e43@amd.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 27 Jan 2022 17:20:40 -0600 "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com> wrote:

> Andrew,
> We're somehow new on this procedure. Are you referring to rebase this 
> patch series to
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 
> <5.17-rc1 tag>?

No, against current Linus mainline, please.
