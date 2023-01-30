Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BAE680568
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jan 2023 06:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjA3FHt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Jan 2023 00:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjA3FHs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Jan 2023 00:07:48 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE37C665
        for <linux-ext4@vger.kernel.org>; Sun, 29 Jan 2023 21:07:46 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30U57XwU018019
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 00:07:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1675055255; bh=JWmiNveseVYXLBAsx+JuY1bUqjB7giutIAAzlj8j4bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=hnWFstBsGfbA0hpINGDsahR+oUfNOrU2qO5zhe73Iv/D/VwhYGIzCMs/mW/IKcu7D
         C8e9c6ItkXImdZW3m6kUa+djwjPsNGryBVRCoINYIPiEWmTuKlN1HTGxoH2MvODjv+
         GpDoZDj3pKiqWUvWQwWpH/8qKVJMjVdK/UK3cl9STkpX9Qsg5ZbkhtPTeZRV/x/q94
         m0cFOv71SSEfzAaCmtQ5apiTMsz2+HKJvYbXUNcIddJ0QUI0yUB+tWPw+4TkcBYoIx
         dEQMpWCvOkM0WFr8+zL830asFfJbweBmuk89zKyLN7v/mYg7mnBD3653Ncvx8N78G0
         qnJQhxLXstFvQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8F2E815C3589; Mon, 30 Jan 2023 00:07:33 -0500 (EST)
Date:   Mon, 30 Jan 2023 00:07:33 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/4] ci.yml: ensure -Werror really gets used in all cases
Message-ID: <Y9dQlZF1v6ECD+JN@mit.edu>
References: <20230128224651.59593-1-ebiggers@kernel.org>
 <20230128224651.59593-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128224651.59593-2-ebiggers@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Jan 28, 2023 at 02:46:48PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> -Werror wasn't actually being used when building the libraries, as the
> libraries use CFLAGS_STLIB instead of CFLAGS.
> 
> Use CFLAGS_WARN, which gets included in both.
> 
> Note: -Werror can't just be passed to 'configure' like the other flags
> are, as it interferes with some of the configure checks.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied on the maint branch, thanks.

					- Ted
