Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7ED63EA709
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Aug 2021 17:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238249AbhHLPCf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Aug 2021 11:02:35 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38323 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238247AbhHLPCd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Aug 2021 11:02:33 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17CF239N022185
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 11:02:04 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3F96E15C37C1; Thu, 12 Aug 2021 11:02:03 -0400 (EDT)
Date:   Thu, 12 Aug 2021 11:02:03 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 4/5] ext4: Orphan file documentation
Message-ID: <YRU36wzThGyQ2902@mit.edu>
References: <20210811101006.2033-1-jack@suse.cz>
 <20210811101925.6973-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811101925.6973-4-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 11, 2021 at 12:19:14PM +0200, Jan Kara wrote:
> Add documentation about the orphan file feature.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
