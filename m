Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C36B1E72B2
	for <lists+linux-ext4@lfdr.de>; Fri, 29 May 2020 04:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389645AbgE2CnQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 May 2020 22:43:16 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52113 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389601AbgE2CnP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 May 2020 22:43:15 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04T2h8Kh018971
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 22:43:09 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8A9F4420304; Thu, 28 May 2020 22:43:08 -0400 (EDT)
Date:   Thu, 28 May 2020 22:43:08 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] ext4: Drop ext4_journal_free_reserved()
Message-ID: <20200529024308.GG228632@mit.edu>
References: <20200520133119.1383-1-jack@suse.cz>
 <20200520133119.1383-2-jack@suse.cz>
 <880DF805-D78D-427A-A53F-FD8CFB00B5E3@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <880DF805-D78D-427A-A53F-FD8CFB00B5E3@dilger.ca>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 20, 2020 at 01:29:01PM -0600, Andreas Dilger wrote:
> On May 20, 2020, at 7:31 AM, Jan Kara <jack@suse.cz> wrote:
> > 
> > Remove ext4_journal_free_reserved() function. It is never used.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Thanks, applied.

					- Ted
