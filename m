Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700DD2808AB
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Oct 2020 22:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733103AbgJAUoC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Oct 2020 16:44:02 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38067 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733122AbgJAUnW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Oct 2020 16:43:22 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 091KhHDF022186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Oct 2020 16:43:18 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4C03B42003C; Thu,  1 Oct 2020 16:43:17 -0400 (EDT)
Date:   Thu, 1 Oct 2020 16:43:17 -0400
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/4] e2fsck: remove unused variable 'new_array'
Message-ID: <20201001204317.GN23474@mit.edu>
References: <20200605081442.13428-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605081442.13428-1-lczerner@redhat.com>
hFrom:  "Theodore Y. Ts'o" <tytso@mit.edu>
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks, this was fixed already.

				- Ted
