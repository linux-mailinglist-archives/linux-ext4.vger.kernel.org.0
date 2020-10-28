Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4C329D28F
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Oct 2020 22:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgJ1Vd0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Oct 2020 17:33:26 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56515 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725913AbgJ1VdU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Oct 2020 17:33:20 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09S3g0HY021833
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Oct 2020 23:42:00 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3B8B6420107; Tue, 27 Oct 2020 23:42:00 -0400 (EDT)
Date:   Tue, 27 Oct 2020 23:42:00 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Benno Schulenberg <bensberg@telfort.nl>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] release notes: delete two files that are fully contained
 within v1.41.txt
Message-ID: <20201028034200.GA930563@mit.edu>
References: <20201020095612.3459-1-bensberg@telfort.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020095612.3459-1-bensberg@telfort.nl>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 20, 2020 at 11:56:12AM +0200, Benno Schulenberg wrote:
> They are pure duplicates.
> 
> Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>

Thanks, applied.

					- Ted
