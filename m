Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E87B30D241
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Feb 2021 04:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhBCDw5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Feb 2021 22:52:57 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33535 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230000AbhBCDw4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Feb 2021 22:52:56 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1133q4us017075
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 Feb 2021 22:52:05 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A071215C39E2; Tue,  2 Feb 2021 22:52:04 -0500 (EST)
Date:   Tue, 2 Feb 2021 22:52:04 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Benno Schulenberg <bensberg@telfort.nl>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] tune2fs.8: fix various wording and formatting issues
Message-ID: <YBod5PEglEcgGq2s@mit.edu>
References: <20201020094829.3234-1-bensberg@telfort.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020094829.3234-1-bensberg@telfort.nl>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 20, 2020 at 11:48:28AM +0200, Benno Schulenberg wrote:
> For example: the argument of -c had a mistaken plural "s", the argument
> of -o was misformatted, the main description spoke of "options" instead
> of "parameters" and used a mistaken "i.e." instead of "e.g.", and so on.
> 
> Also, sort the options in the synopsis alphabetically, to make it easier
> to find a specific one and to match the order in which they are listed
> further down.  Also, remove some excess spaces, harmonize the style of
> some decriptions, sort d, w, m in the order of ascending duration, and
> for consistency use hyphens instead of underscores in option arguments.
> 
> Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>

Thanks, applied.  (Apologies for missing this before the 1.45.7 release.)

		  	     	 	 - Ted
