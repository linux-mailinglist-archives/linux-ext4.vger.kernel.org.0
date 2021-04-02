Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2922352C92
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Apr 2021 18:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbhDBPkd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Apr 2021 11:40:33 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60117 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229553AbhDBPkd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Apr 2021 11:40:33 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 132FeJh5012338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Apr 2021 11:40:20 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A873C15C3AC7; Fri,  2 Apr 2021 11:40:19 -0400 (EDT)
Date:   Fri, 2 Apr 2021 11:40:19 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Cc:     Jan Kara <jack@suse.cz>,
        Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Updated locking documentation for journal_t
Message-ID: <YGc642aVrbAN77rT@mit.edu>
References: <20210210095740.54881-1-alexander.lochmann@tu-dortmund.de>
 <20210211093754.GJ19070@quack2.suse.cz>
 <ad82c7a9-a624-4ed5-5ada-a6410c44c0b3@tu-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad82c7a9-a624-4ed5-5ada-a6410c44c0b3@tu-dortmund.de>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 11, 2021 at 10:51:55AM +0100, Alexander Lochmann wrote:
> Some members of transaction_t are allowed to be read without
> any lock being held if consistency doesn't matter.
> Based on LockDoc's findings, we extended the locking
> documentation of those members.
> Each one of them is marked with a short comment:
> "no lock for quick racy checks".
> 
> Signed-off-by: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
> Signed-off-by: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.  I had to fix up the patch, which was mailer-damaged,
and I also reflowed the comments.

					- Ted
