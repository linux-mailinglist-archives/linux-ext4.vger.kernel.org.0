Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C546306B3A
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Jan 2021 03:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhA1CuW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jan 2021 21:50:22 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38557 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229494AbhA1CuW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jan 2021 21:50:22 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10S2nSX6015041
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 21:49:28 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id EC92715C344F; Wed, 27 Jan 2021 21:49:27 -0500 (EST)
Date:   Wed, 27 Jan 2021 21:49:27 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     linux-ext4@vger.kernel.org, drosen@google.com,
        krisman@collabora.com, ebiggers@kernel.org
Subject: Re: [PATCH RESEND v2 04/12] ext2fs: Implement faster CI comparison
 of strings
Message-ID: <YBImN/d4SmLa8red@mit.edu>
References: <20201210150353.91843-1-arnaud.ferraris@collabora.com>
 <20201210150353.91843-5-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210150353.91843-5-arnaud.ferraris@collabora.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 10, 2020 at 04:03:45PM +0100, Arnaud Ferraris wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Instead of calling casefold two times and memcmp the result, which
> require allocating a temporary buffer for the casefolded version, add a
> strcasecmp-like method to perform the comparison of each code-point
> during the casefold itself.
> 
> This method is exposed because it needs to be used directly by fsck.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>

Thanks, applied.

					- Ted
