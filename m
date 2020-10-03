Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFED28210A
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Oct 2020 06:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbgJCEIw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 3 Oct 2020 00:08:52 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40291 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725446AbgJCEIw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 3 Oct 2020 00:08:52 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09348ipi015629
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 3 Oct 2020 00:08:45 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BC77142003C; Sat,  3 Oct 2020 00:08:44 -0400 (EDT)
Date:   Sat, 3 Oct 2020 00:08:44 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca
Subject: Re: [PATCH] ext4: Remove unused argument from ext4_(inc|dec)_count
Message-ID: <20201003040844.GA23474@mit.edu>
References: <20200826133116.11592-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826133116.11592-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 26, 2020 at 04:31:16PM +0300, Nikolay Borisov wrote:
> The 'handle' argument is not used for anything so simply remove it.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Applied, thanks.

					- Ted
