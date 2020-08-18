Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E83248DB6
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Aug 2020 20:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgHRSLX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Aug 2020 14:11:23 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44260 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726435AbgHRSLW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Aug 2020 14:11:22 -0400
Received: from callcc.thunk.org (pool-108-49-65-20.bstnma.fios.verizon.net [108.49.65.20])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 07IIBH74010436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 14:11:18 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C1C62420DC0; Tue, 18 Aug 2020 14:11:17 -0400 (EDT)
Date:   Tue, 18 Aug 2020 14:11:17 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext4: flag as supporting buffered async reads
Message-ID: <20200818181117.GA34125@mit.edu>
References: <fb90cc2d-b12c-738f-21a4-dd7a8ae0556a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb90cc2d-b12c-738f-21a4-dd7a8ae0556a@kernel.dk>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 03, 2020 at 05:02:11PM -0600, Jens Axboe wrote:
> ext4 uses generic_file_read_iter(), which already supports this.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> Resending this one, as I've been carrying it privately since May. The
> necessary bits are now upstream (and XFS/btrfs equiv changes as well),
> please consider this one for 5.9. Thanks!

The necessary commit only hit upstream as of 5.9-rc1, unless I'm
missing something?  It's on my queue to send to Linus once I get my
(late) ext4 primary pull request for 5.9.

						- Ted
