Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EC935301A
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Apr 2021 22:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhDBUFP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Apr 2021 16:05:15 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54798 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229647AbhDBUFO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Apr 2021 16:05:14 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 132K592s029436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Apr 2021 16:05:10 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id ACE7315C3ACE; Fri,  2 Apr 2021 16:05:09 -0400 (EDT)
Date:   Fri, 2 Apr 2021 16:05:09 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@whamcloud.com>
Cc:     linux-ext4@vger.kernel.org, Wang Shilong <wshilong@whamcloud.com>
Subject: Re: [PATCH] filefrag: minor usability improvements
Message-ID: <YGd49Qv6GLIKPZ8+@mit.edu>
References: <20210310224715.18467-1-adilger@whamcloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310224715.18467-1-adilger@whamcloud.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 10, 2021 at 03:47:15PM -0700, Andreas Dilger wrote:
> Add '-V' to filefrag to print the installed version of the tool.
> 
> If '-V' is used twice, print out the list of supported FIEMAP flags.
> This can be used to check if filefrag understands a specific feature.
> 
> Include FIEMAP in the error message printed when filefrag cannot
> get the file layout. Since FIEMAP is commonly available and tried
> first, it should also be mentioned in the error message unless it
> was requested to only run FIBMAP.
> 
> Update filefrag.1.in man page to cover the new -V option.
> 
> Fix a formatting error with the recently added '-P' options, and
> include '-E' and '-P' in the SYNOPSIS section.
> 
> Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
> Lustre-bug-id: https://jira.whamcloud.com/browse/LU-11848
> Reviewed-by: Wang Shilong <wshilong@whamcloud.com>
> Change-Id: Ib126bdd70efa1775aef6db761f54e27a593ebbe5

Applied, thanks.

					- Ted
