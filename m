Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4CC28F542
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Oct 2020 16:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389431AbgJOOvh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 10:51:37 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52152 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389452AbgJOOvg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Oct 2020 10:51:36 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09FEnwDY032121
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Oct 2020 10:49:59 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 36CD6420107; Thu, 15 Oct 2020 10:49:58 -0400 (EDT)
Date:   Thu, 15 Oct 2020 10:49:58 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        Fengnan Chang <changfengnan@hikvision.com>, adilger@dilger.ca,
        changfengnan <fengnanchang@foxmail.com>
Subject: Re: [PATCH v6] jbd2: avoid transaction reuse after reformatting
Message-ID: <20201015144958.GC181507@mit.edu>
References: <20201012164900.20197-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012164900.20197-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 12, 2020 at 06:49:00PM +0200, Jan Kara wrote:
> From: changfengnan <fengnanchang@foxmail.com>
> 
> When ext4 is formatted with lazy_journal_init=1 and transactions from
> the previous filesystem are still on disk, it is possible that they are
> considered during a recovery after a crash. Because the checksum seed
> has changed, the CRC check will fail, and the journal recovery fails
> with checksum error although the journal is otherwise perfectly valid.
> Fix the problem by checking commit block time stamps to determine
> whether the data in the journal block is just stale or whether it is
> indeed corrupt.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Fengnan Chang <changfengnan@hikvision.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted
