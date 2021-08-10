Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6853E5E7F
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Aug 2021 16:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242242AbhHJO7W (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Aug 2021 10:59:22 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56824 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239178AbhHJO7W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Aug 2021 10:59:22 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17AEwu3q015734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Aug 2021 10:58:56 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 36BC615C3DD0; Tue, 10 Aug 2021 10:58:56 -0400 (EDT)
Date:   Tue, 10 Aug 2021 10:58:56 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/7] e2fsck: value stored to err is never read
Message-ID: <YRKUMP51280FXK7F@mit.edu>
References: <20210806095820.83731-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806095820.83731-1-lczerner@redhat.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 06, 2021 at 11:58:14AM +0200, Lukas Czerner wrote:
> Remove it to silence clang warning.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Applied, thanks.

Note that we try to keep e2fsck/recovery.c and fs/jbd2/recovery.c in
sync, so it's appreciated patches sent to e2fsck/recovery.c or
fs/jbd2/recovery.c is sent to the other.  I can take care of it in
this case.

Cheers,

					- Ted
