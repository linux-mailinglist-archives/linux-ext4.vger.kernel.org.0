Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCA7139C8F
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2020 23:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgAMWcb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Jan 2020 17:32:31 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59152 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728733AbgAMWcb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Jan 2020 17:32:31 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00DMWPL0002733
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 17:32:26 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 780124207DF; Mon, 13 Jan 2020 17:32:25 -0500 (EST)
Date:   Mon, 13 Jan 2020 17:32:25 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Naoto Kobayashi <naoto.kobayashi4c@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ext4: Delete ext4_kvzvalloc()
Message-ID: <20200113223225.GK76141@mit.edu>
References: <20191227080523.31808-1-naoto.kobayashi4c@gmail.com>
 <20191227080523.31808-2-naoto.kobayashi4c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227080523.31808-2-naoto.kobayashi4c@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 27, 2019 at 05:05:21PM +0900, Naoto Kobayashi wrote:
> Since we're not using ext4_kvzalloc(), delete this function.
> 
> Signed-off-by: Naoto Kobayashi <naoto.kobayashi4c@gmail.com>

Thanks, applied.

					- Ted
