Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6C4281C9E
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Oct 2020 22:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgJBUIs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Oct 2020 16:08:48 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58661 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725550AbgJBUIs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Oct 2020 16:08:48 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 092K8jLn032163
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Oct 2020 16:08:45 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E67AA42003C; Fri,  2 Oct 2020 16:08:44 -0400 (EDT)
Date:   Fri, 2 Oct 2020 16:08:44 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext4: flag as supporting buffered async reads
Message-ID: <20201002200844.GW23474@mit.edu>
References: <fb90cc2d-b12c-738f-21a4-dd7a8ae0556a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb90cc2d-b12c-738f-21a4-dd7a8ae0556a@kernel.dk>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 03, 2020 at 05:02:11PM -0600, Jens Axboe wrote:
> ext4 uses generic_file_read_iter(), which already supports this.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Applied, thanks.   (And apologies for the delay.)

				- Ted
