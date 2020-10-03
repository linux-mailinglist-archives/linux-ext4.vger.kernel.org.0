Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829A1282101
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Oct 2020 06:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgJCEF6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 3 Oct 2020 00:05:58 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39516 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725747AbgJCEF5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 3 Oct 2020 00:05:57 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09345d54013563
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 3 Oct 2020 00:05:40 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BD93F42003C; Sat,  3 Oct 2020 00:05:39 -0400 (EDT)
Date:   Sat, 3 Oct 2020 00:05:39 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Petr Malat <oss@malat.biz>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca
Subject: Re: [PATCH] ext4: Do not interpret high bytes if 64bit feature is
 disabled
Message-ID: <20201003040539.GZ23474@mit.edu>
References: <20200825150016.3363-1-oss@malat.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825150016.3363-1-oss@malat.biz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 25, 2020 at 05:00:16PM +0200, Petr Malat wrote:
> Fields s_free_blocks_count_hi, s_r_blocks_count_hi and s_blocks_count_hi
> are not valid if EXT4_FEATURE_INCOMPAT_64BIT is not enabled and should be
> treated as zeroes.
> 
> Signed-off-by: Petr Malat <oss@malat.biz>

Thanks, applied.

					- Ted
