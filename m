Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39A61D3349
	for <lists+linux-ext4@lfdr.de>; Thu, 14 May 2020 16:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgENOnL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 May 2020 10:43:11 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57411 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726066AbgENOnL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 May 2020 10:43:11 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04EEh6Yd003567
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 10:43:06 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 22D7F420304; Thu, 14 May 2020 10:43:06 -0400 (EDT)
Date:   Thu, 14 May 2020 10:43:06 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] ext4: remove EXT4_GET_BLOCKS_KEEP_SIZE flag
Message-ID: <20200514144306.GQ1596452@mit.edu>
References: <20200415203140.30349-1-enwlinux@gmail.com>
 <20200415203140.30349-2-enwlinux@gmail.com>
 <20200422161214.GE20756@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422161214.GE20756@quack2.suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 22, 2020 at 06:12:14PM +0200, Jan Kara wrote:
> On Wed 15-04-20 16:31:39, Eric Whitney wrote:
> > The eofblocks code was removed in the 5.7 release by "ext4: remove
> > EOFBLOCKS_FL and associated code" (4337ecd1fe99).  The ext4_map_blocks()
> > flag used to trigger it can now be removed as well.
> > 
> > Signed-off-by: Eric Whitney <enwlinux@gmail.com>
> 
> Looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
