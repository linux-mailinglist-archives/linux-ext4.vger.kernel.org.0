Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6D26D8DCC
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Apr 2023 04:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbjDFC6p (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 22:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbjDFC6n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 22:58:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2285BA9;
        Wed,  5 Apr 2023 19:58:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B800164174;
        Thu,  6 Apr 2023 02:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D88EC433EF;
        Thu,  6 Apr 2023 02:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680749921;
        bh=AwNKZCoYNd9/YP0f3fwLMwmGowD98qoCr8vn5oD6464=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=sh8jz2Dhf+RNZdqkp2D3by0mDvHPrh5wn5Z3yWg7pHjeZq7R3N3tBIhDQQ5P2Sv94
         bqmPUw+vKrz4LIbZ8t8xF2pjN9CUeFYEp8Z3sXtmZuIqPd4pRPcFCOAJioO6bS6QKC
         X2v24E+ZiOI7+vHikKrwFJRGTG88wZgUFOrgdjGT36ejgGYCXp+LZ7T+/cKxirhjvO
         HBUGAC3/rVWNpHCNvQPHxO4ltUMT4b12OdRcIaoA4/s7XEZiodPeuoKAqi6QN/4Av+
         Nf6scwmZOUKHGNwSvUmAihxgtk0aqkG62/ZCIyks/lANllGyAFFJOelhSr1DUUk/mA
         iA8NpGwLilr9Q==
Date:   Wed, 05 Apr 2023 19:58:40 -0700
From:   Kees Cook <kees@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Kees Cook <keescook@chromium.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_0/3=5D_lib/string=5Fhelpers_et?= =?US-ASCII?Q?_al=2E=3A_Change_return_value_of_strreplace=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZC2H8ODMwoO5hzZG@smile.fi.intel.com>
References: <20230323123704.37983-1-andriy.shevchenko@linux.intel.com> <ZC1454AwRUNFTbIW@smile.fi.intel.com> <2023040523-unworthy-uncured-1eab@gregkh> <ZC2H8ODMwoO5hzZG@smile.fi.intel.com>
Message-ID: <47D8878A-1108-4AC3-BF7F-507F90F6970A@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On April 5, 2023 7:38:40 AM PDT, Andy Shevchenko <andriy=2Eshevchenko@linux=
=2Eintel=2Ecom> wrote:
>On Wed, Apr 05, 2023 at 04:24:42PM +0200, Greg Kroah-Hartman wrote:
>> On Wed, Apr 05, 2023 at 04:34:31PM +0300, Andy Shevchenko wrote:
>> > On Thu, Mar 23, 2023 at 02:37:01PM +0200, Andy Shevchenko wrote:
>> > > It's more convenient to have strreplace() to return the pointer to
>> > >  the string itself=2E This will help users to make their code bette=
r=2E
>> > >=20
>> > > The patch 1 kills the only user of the returned value of strreplace=
(),
>> > > Patch 2 converts the return value of strreplace()=2E And patch 3 sh=
ows
>> > > how it may be useful=2E That said, the series can be routed via fs =
tree,
>> > > with or without the last patch=2E
>> >=20
>> > Since there are no comments, who can apply this (patches 1 and 2)?
>> > Greg, are you fine with the kobject change?
>>=20
>> Sure, want me to take them all through my driver-core tree?
>
>Fine by me! Dunno about others=2E Kees?

Yeah, that's cool by me=2E :)


--=20
Kees Cook
