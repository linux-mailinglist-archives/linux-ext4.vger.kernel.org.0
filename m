Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4739C56A577
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Jul 2022 16:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbiGGOdO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jul 2022 10:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbiGGOdO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Jul 2022 10:33:14 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CE72F3B3
        for <linux-ext4@vger.kernel.org>; Thu,  7 Jul 2022 07:33:12 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 267EWx2d001638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Jul 2022 10:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1657204380; bh=tzjxZhYxR8YeR6sL7Mssq9EcRCN8KJKUPRMmdOg+NFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=FoHu3kRX61GDZp0g6k94UmvS3cmaMklF3UVyzpATWlyyMQHvd1334QBLfO0yHUTFH
         YbYZ1eA4+ke5W+6zDTsCbwZEOmHKUI2Arn0ZnmIlIhVbY5fc7W0LiE7H3MucC+d3Xf
         RWvMwmMddHL//+kTVKgxQ0ks/DA27Fq/BdFfrV6AOtBvLtiT0IPa/O8TKCAfXLi/+Z
         gSMJd27vIny8OV7NyP17YIeBdFw4zJE4Dyo9tWwuh+SH0WPUGMrDlJiSkQqwuAXSQ0
         TZN2RwpjmLTYT23xy5VfkBEJmtD11b/0jhv/8fToSHdiAXJS8dipAa5P+xcXIfiwzB
         DCkhNJKIpRQ3A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E330615C433C; Thu,  7 Jul 2022 10:32:58 -0400 (EDT)
Date:   Thu, 7 Jul 2022 10:32:58 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        stable@kernel.org
Subject: Re: [PATCH 1/2] ext4: update s_overhead_clusters in the superblock
 during an on-line resize
Message-ID: <YsbumgHCsinwGuCx@mit.edu>
References: <20220629040026.112371-1-tytso@mit.edu>
 <2F240021-C24A-4F86-ACDA-2FF944F9FE6F@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2F240021-C24A-4F86-ACDA-2FF944F9FE6F@dilger.ca>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 04, 2022 at 02:47:43PM -0600, Andreas Dilger wrote:
> On Jun 28, 2022, at 10:00 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> > 
> > When doing an online resize, the on-disk superblock on-disk wasn't
> > updated.  This means that when the file system is unmounted and
> > remounted, and the on-disk overhead value is non-zero, this would
> > result in the results of statfs(2) to be incorrect.
> > 
> > This was partially fixed by Commits 10b01ee92df5 ("ext4: fix overhead
> > calculation to account for the reserved gdt blocks"), 85d825dbf489
> > ("ext4: force overhead calculation if the s_overhead_cluster makes no
> > sense"), and eb7054212eac ("ext4: update the cached overhead value in
> > the superblock").
> 
> Would these be better referenced by Fixes: labels?

This commit doesn't actually _fix_ the above-mentioned commits.  They
just didn't fix the bug which is addressed by this one.

Cheers,

						- Ted
