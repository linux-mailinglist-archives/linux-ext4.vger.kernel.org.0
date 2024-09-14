Return-Path: <linux-ext4+bounces-4159-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0149790CD
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Sep 2024 14:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DF54B23400
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Sep 2024 12:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B881CF5E2;
	Sat, 14 Sep 2024 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCA2Po7Y"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81381993B0
	for <linux-ext4@vger.kernel.org>; Sat, 14 Sep 2024 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726318434; cv=none; b=jYnyYOP7xi/ULd/scKXLIPw2b9ByY1VHLuLwLq5OMGqMCrAZdD6FQ01HOfVYNKTtJITBarwitDuuA9DadSecKojrIDT4HXTCKBHVbJKRNbmUc+nU+ryjtD5vlt56x7YoOe3yLuNFWs+UzbMxnss3rb8fttVNJmChatgsX++B6Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726318434; c=relaxed/simple;
	bh=sDrPq17lStfCELnBPLMLI0f4JeytQPZi1SuTKPctVFM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d+nYcTJfHDLnhs6LrR6PxBgmZN0z4eV8SEAetNpO2GwYy4R9VBUs80FxHHYqVnuoQymLjRQJf3sY+R5IMEC13MjKaVIKFf19Wv6JVfzXJHER7tC68n+q3Wq3SC561fMNPLGJCMrjyjtt/11GOaZXtiDcsZ+oWBTmbQ2ad5jQ/kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCA2Po7Y; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3770320574aso2224511f8f.2
        for <linux-ext4@vger.kernel.org>; Sat, 14 Sep 2024 05:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726318431; x=1726923231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=e9XmQMvE7VLa2KPeYDescK4eoWpmI0a+rkwHZh9R2Bk=;
        b=hCA2Po7YVi5E3lSGyJOhekcCQqMg8m80/lNaXsMAeHajIPgr/IFSAcPMCkqgDQ8ls6
         YZ1XsK9wCfxkXcqAscfoPPe8O/ODgtoZIYGnTsaTnMZyEdIiBOVGqdzXX4CD7FWakczp
         8C//yue3jDejAwcsdKJ+w0OvcdwxwOzKqL9YSZ24C7PpQKx1oXMArJ5ogjxvtCsaQ3RF
         gmM9XJjAUHwOrwJ4hVvoYaDW8FHS8PXj1TGsAnlzjhHZuH2TSQbW4dQeMvGM/fel4XvM
         N0brx/Bh5WxIfui6ppvq/X/VrzacfIdnQIRSrbMpM0sFbyLlAnYKn4OIi3HrJzNZp0Ru
         sGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726318431; x=1726923231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9XmQMvE7VLa2KPeYDescK4eoWpmI0a+rkwHZh9R2Bk=;
        b=PdmvkV54jEsBNb1xjf8yOYICDR2jyqsbLhck1BZLCFItbfARqpMunXtKMwYjprctxc
         FXbbjeW3nhAiIzChPypjQ5B40XaAmY7YJG7DdLUxPR2K/ZQLvGKUtbyeyVONB9mGdRl+
         mg7CffG8YnZAnumjrCQSMU1kjys/vX19CYfsyToUYfs+WRdrH02G98Q49tf2A7wvCrw5
         tv4kBkx3Q+/sWyc/s1Q+c5ehhtC/lzyQROjCLoEkLDMh9MPCEfXoPwUn5yiw5po41WD1
         APoiQbynFW0AK9NcMLxMIG4C1xbwwMfnghcmwItSml7D9tZvoPcbXwKOyjDYnCt8fxR7
         52lA==
X-Gm-Message-State: AOJu0YzeI4IgLeY5971PqcWZ3ohSmOlfY28SUS7Oj6LZdMPk7+Hr3vFi
	3PzakNmTe2HaLwv7TDhzvCTW1IffbEa1GDwZmdTOuB4xK/htrCBc9I6CauUn
X-Google-Smtp-Source: AGHT+IF4MNHV+DBzic9xmOYs4fWemcbcE5s6cW4WO31UDtnWRiEZE8W2KRFgIt5UdlgMaQ0p0xGDEg==
X-Received: by 2002:a5d:6551:0:b0:374:c977:7453 with SMTP id ffacd0b85a97d-378c2d114bemr5726046f8f.25.1726318430862;
        Sat, 14 Sep 2024 05:53:50 -0700 (PDT)
Received: from Max.. ([5.29.180.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b05d6fcsm51652595e9.15.2024.09.14.05.53.50
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 05:53:50 -0700 (PDT)
From: Max <linmaxi@gmail.com>
To: linux-ext4@vger.kernel.org
Subject: [PROBLEM] all warnings being treated as errors when I try to compile ext4 subtree
Date: Sat, 14 Sep 2024 15:53:26 +0300
Message-ID: <20240914125340.44480-1-linmaxi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I have cloned the ext4 subtree: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
Then I tried to build it, first by making a .config file, and then running make.
The make won't finish beacuse I am getting this "all warnings being treated as errors":

In file included from help.c:12:
subcmd-util.h: In function ‘xrealloc’:
subcmd-util.h:58:31: error: pointer ‘ptr’ may be used after ‘realloc’ [-Werror=use-after-free]
   58 |                         ret = realloc(ptr, 1);
      |                               ^~~~~~~~~~~~~~~
subcmd-util.h:52:21: note: call to ‘realloc’ here
   52 |         void *ret = realloc(ptr, size);
      |                     ^~~~~~~~~~~~~~~~~~
subcmd-util.h:56:23: error: pointer ‘ptr’ may be used after ‘realloc’ [-Werror=use-after-free]
   56 |                 ret = realloc(ptr, size);
      |                       ^~~~~~~~~~~~~~~~~~
subcmd-util.h:52:21: note: call to ‘realloc’ here
   52 |         void *ret = realloc(ptr, size);
      |                     ^~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[5]: *** [/home/max/kernels/ext4/tools/build/Makefile.build:97: /home/max/kernels/build_ext4/tools/objtool/help.o] Error 1

Worth mentioning that trying to 'make' the mainline tree works fine.
I have tried adding the -Wno-error flag but it didnt work and anyway I think I shouldn't attempt changing it at all in order to build.

I would appreciate any help, I am a newbie, and I'd like to help fixing some bugs.

