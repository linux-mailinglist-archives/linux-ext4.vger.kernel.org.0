Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6288535D5F5
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Apr 2021 05:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240959AbhDMDer (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Apr 2021 23:34:47 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45805 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239104AbhDMDeq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Apr 2021 23:34:46 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13D3YOnq001454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 23:34:24 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id EFD9715C3B1E; Mon, 12 Apr 2021 23:34:23 -0400 (EDT)
Date:   Mon, 12 Apr 2021 23:34:23 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     stable@kernel.org
Subject: Re: [PATCH] ext4: allow the dax flag to be set and cleared on inline
 directories
Message-ID: <YHURP6tLbmOBtAj8@mit.edu>
References: <20210413033124.2256508-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413033124.2256508-1-tytso@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 12, 2021 at 11:31:24PM -0400, Theodore Ts'o wrote:
> This is needed to allow generic/620 to pass for file systems with the

"generic/620" was a typo --- it should have been "generic/607"

> inline data_feature enabled, and it allows the use of file systems
> where the directories use inline_data, while the files are accessed
> via DAX.

					- Ted
