Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6C67139A13
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2020 20:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgAMTUQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Jan 2020 14:20:16 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53668 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726435AbgAMTUP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Jan 2020 14:20:15 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00DJK7lo030937
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 14:20:10 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 56CE74207DF; Mon, 13 Jan 2020 14:20:07 -0500 (EST)
Date:   Mon, 13 Jan 2020 14:20:07 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] docs: ext4.rst: add encryption and verity to features
 list
Message-ID: <20200113192007.GG30418@mit.edu>
References: <20191226154007.4569-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191226154007.4569-1-ebiggers@kernel.org>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 26, 2019 at 09:40:07AM -0600, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Mention encryption and verity in the ext4 features list.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

				- Ted
