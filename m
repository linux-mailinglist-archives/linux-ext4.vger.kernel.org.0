Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77B184C5F9
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2019 06:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbfFTECB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jun 2019 00:02:01 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45909 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725857AbfFTECB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jun 2019 00:02:01 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5K41u2f005812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jun 2019 00:01:57 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5CE5A420484; Thu, 20 Jun 2019 00:01:56 -0400 (EDT)
Date:   Thu, 20 Jun 2019 00:01:56 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-ext4@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] ext4: Optimize case-insensitive lookups
Message-ID: <20190620040156.GB15783@mit.edu>
References: <20190617190240.30996-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617190240.30996-1-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 17, 2019 at 03:02:40PM -0400, Gabriel Krisman Bertazi wrote:
> Temporarily cache a casefolded version of the file name under lookup in
> ext4_filename, to avoid repeatedly casefolding it.  I got up to 30%
> speedup on lookups of large directories (>100k entries), depending on
> the length of the string under lookup.
> 
> v2:
>   - Dinamically allocate space for the casefolded version.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Thanks, applied.

						- Ted
