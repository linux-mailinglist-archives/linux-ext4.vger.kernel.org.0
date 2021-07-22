Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8795F3D2647
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Jul 2021 16:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbhGVONU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Jul 2021 10:13:20 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36315 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232559AbhGVOMo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Jul 2021 10:12:44 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16MEr8Zd014436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jul 2021 10:53:08 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DE08815C37C0; Thu, 22 Jul 2021 10:53:07 -0400 (EDT)
Date:   Thu, 22 Jul 2021 10:53:07 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH 2/5] ext4: Move orphan inode handling into a separate file
Message-ID: <YPmGU6pYwI445X2B@mit.edu>
References: <20210712154009.9290-1-jack@suse.cz>
 <20210712154009.9290-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712154009.9290-3-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 12, 2021 at 05:40:06PM +0200, Jan Kara wrote:
> Move functions for handling orphan inodes into a new file
> fs/ext4/orphan.c to have them in one place and somewhat reduce size of
> other files. No code changes.

Makes sense.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
