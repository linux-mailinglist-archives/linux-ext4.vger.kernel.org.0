Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125A542D078
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Oct 2021 04:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbhJNCfC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Oct 2021 22:35:02 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44929 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229879AbhJNCfC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Oct 2021 22:35:02 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19E2WgE9011854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 22:32:43 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5D22715C00CA; Wed, 13 Oct 2021 22:32:42 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhang Yi <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, yukuai3@huawei.com, jack@suse.cz,
        adilger.kernel@dilger.ca
Subject: Re: [RFC PATCH 0/3] ext4: enhance extent consistency check
Date:   Wed, 13 Oct 2021 22:32:39 -0400
Message-Id: <163416151699.223555.16012336427055541414.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210908120850.4012324-1-yi.zhang@huawei.com>
References: <20210908120850.4012324-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 8 Sep 2021 20:08:47 +0800, Zhang Yi wrote:
> Now that in the error patch of extent updating procedure cannot handle
> error and roll-back partial updates properly, so we could access the
> left inconsistent extent buffer later and lead to BUGON in
> errors=continue mode. For example, we could get below BUGON if we
> update leaf extent but failed to update index extent in
> ext4_ext_insert_extent() and try to alloc block again.
> 
> [...]

Applied, thanks!

[1/3] ext4: check for out-of-order index extents in ext4_valid_extent_entries()
      commit: efbcc1015b07e3e8bafa97394b743812c180a9dd
[2/3] ext4: check for inconsistent extents between index and leaf block
      commit: a992bc717652fb15b435884c587ae5249415239c
[3/3] ext4: prevent partial update of the extent blocks
      commit: 916ff8d5ea0e24fd43f113b6b5326d5ea8f68310

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
