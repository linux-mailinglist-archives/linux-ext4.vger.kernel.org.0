Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F0E2808AC
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Oct 2020 22:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733093AbgJAUoC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Oct 2020 16:44:02 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38111 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733177AbgJAUnd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Oct 2020 16:43:33 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 091KhSqZ022276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Oct 2020 16:43:29 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4E14B42003C; Thu,  1 Oct 2020 16:43:28 -0400 (EDT)
Date:   Thu, 1 Oct 2020 16:43:28 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/4] e2fsck: use size_t instead of int in string_copy()
Message-ID: <20201001204328.GO23474@mit.edu>
References: <20200605081442.13428-1-lczerner@redhat.com>
 <20200605081442.13428-2-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605081442.13428-2-lczerner@redhat.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jun 05, 2020 at 10:14:40AM +0200, Lukas Czerner wrote:
> len argument in string_copy() is int, but it is used with malloc(),
> strlen(), strncpy() and some callers use sizeof() to pass value in. So
> it really ought to be size_t rather than int. Fix it.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Thanks, applied.

					- Ted
