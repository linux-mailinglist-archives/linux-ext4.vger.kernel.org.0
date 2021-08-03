Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A733DF23F
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Aug 2021 18:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhHCQNd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Aug 2021 12:13:33 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60414 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232198AbhHCQNa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Aug 2021 12:13:30 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 173GDEix020502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Aug 2021 12:13:14 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E9C9D15C37C0; Tue,  3 Aug 2021 12:13:13 -0400 (EDT)
Date:   Tue, 3 Aug 2021 12:13:13 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/9] quota: Do not account space used by project quota
 file to quota
Message-ID: <YQlrGbFgxf8BYruB@mit.edu>
References: <20210616105735.5424-1-jack@suse.cz>
 <20210616105735.5424-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616105735.5424-3-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 16, 2021 at 12:57:28PM +0200, Jan Kara wrote:
> Project quota files have high inode numbers but are not accounted in
> quota usage. Do not track them when computing quota usage.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks, applied to the maint branch (since this is a bug fix unrelated
to the orhpan inode feature).

It looks like this was an issue that wasn't picked up by our
regression tests.  Do you have an sample image that you used while you
were developing this patch, that perhaps we should be adding to our
regression test suite?

					- Ted
