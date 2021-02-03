Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B94730D242
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Feb 2021 04:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhBCDy0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Feb 2021 22:54:26 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33686 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230000AbhBCDyZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Feb 2021 22:54:25 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1133rVOX017571
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 Feb 2021 22:53:32 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 62B2915C39E2; Tue,  2 Feb 2021 22:53:31 -0500 (EST)
Date:   Tue, 2 Feb 2021 22:53:31 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Benno Schulenberg <bensberg@telfort.nl>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/2] mke2fs.8: fix various formatting issues, and sort
 the synopsis
Message-ID: <YBoeOxRzNod5npU7@mit.edu>
References: <20201020094829.3234-1-bensberg@telfort.nl>
 <20201020094829.3234-2-bensberg@telfort.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020094829.3234-2-bensberg@telfort.nl>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 20, 2020 at 11:48:29AM +0200, Benno Schulenberg wrote:
> Also, delete the sentence that says that the inode size cannot
> be changed after creating the file system, as tune2fs acquired
> the -I option.
> 
> Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>

Thanks, applied.

					- Ted
