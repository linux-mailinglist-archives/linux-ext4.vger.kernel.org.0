Return-Path: <linux-ext4+bounces-14555-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NGcNh/mpmnjZAAAu9opvQ
	(envelope-from <linux-ext4+bounces-14555-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 14:46:07 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B901F09DE
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 14:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7B063034E18
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2026 13:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CFB2D7D2E;
	Tue,  3 Mar 2026 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="JgGyj5kQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sonic316-20.consmr.mail.ne1.yahoo.com (sonic316-20.consmr.mail.ne1.yahoo.com [66.163.187.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD62829B8D9
	for <linux-ext4@vger.kernel.org>; Tue,  3 Mar 2026 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545165; cv=none; b=r0x25ItdsWa2HgcySS/B3FHh5QzvZEAHcPg9WQqx0UfA8b1xsaElqIHCy3o75+YJxlGqf4hH9d1wVlY4OemSJvV5b8ITnEJqNAd5mfI4d166uLeksbqZhPSKflgOMqDJmMtuyK/YEIRR4q/dXkL5erhC7l2rgwiPdSqldYM6sak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545165; c=relaxed/simple;
	bh=SQeOjelVD4f6TzL6veX/BG5IRz78jJ9iAh8pcsO69N8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ypa5Bas6xKqPxMg0yn8hzVHwMT+FSS2ar4eDce2HBuk49uMseL3jKAUBaDJQCYV5n47RPD7EybxnH+WNnpJpNUzhpUE0Jn8mNN7DYuwSgBDNdrhwUtNmwafhs9jlRLVh8o7aHfq7riN9ubouqefp+l1x7cXmNIp4xgS/26+cTnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=JgGyj5kQ; arc=none smtp.client-ip=66.163.187.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1772545144; bh=AgQogLg7FPGiIEIYvDYGu/57C2o556vqXctsyyx6Ba8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=JgGyj5kQzTjSwuJ72J+PvkMFLco3Xutw0mpT157nK8bz9w5F244kAQWwIkIqtAUHo+JTud6ok/5QHE366vYy54atMnyRiHIMtiBh/0bh23LAwZRrf7FS6RxlKzPmADtMlwh9GGakDVSY3qyPtSpXjLkdJ0x3R0lsJFJoRH2yrM8PEqflnPgL91WG2Ca2FXRJnHFjEspZ4rBcS30E/KZOeL+gDvpm5lP1gFqZa5pc+8aun2I89XQ4V+VEA/z6bH3qv/KjCqqOANNd9DEGXZaUDiELDGga7/ziSDd5EMm0SzOAyxssafcsSNHaBOErVEGck9UBT/vIE65/dQqw8IqZOg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772545144; bh=PR9Vly8bEu9cxI/wtdwDcKcT7fHlhj3p46Heo4N5aXJ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=tU/+C/Cy3sY3AyU5hnqA+sdm8cMPZDXz2ewzVsq71FeaBnrM/r3XJMEJYfQRoNhDEJEkGriBkyiLId0r1UZBN6a7lVmy1BqhXM2zs4qYovyfHWL6AfStXxyt/Orafn/FxHrbAzszyfOG9Zq7IKoYfeZd/2g87PIbjZKGukBF1q5JOaa3ElUeSIy+ItXx9oZ7699L2w+k7VxiQPMjDrPxS+tl8ULkfpeY/b/hFL9bGai6T5i7dBwVBW2VXQ5YGHO6CJyPQ8j4oJhBoI07Kj/9HIDh6urMHPjtsMQwQwsDHvzHrfekczoFtXEn7hcuGbiAf/QvQfk9YtZtjt9Ki7Yb0Q==
X-YMail-OSG: gDovndcVM1lBkdbnVC1_Ef.sFXZwC2ttbMtQm0k4Y58eG4OIzvM_pU0kTkdS9P6
 mhHx4oLAkjAQA5XKjD946Jk.LaMI_0T76MpxL3ZTfjrLf2VMg0yOk7iD1aOtn3ARNudHakQipUgj
 goXmdHJyKiVEBrUFQAloq2HXZu5wLtozKLLcGhBQHufIA5KSvRKVM8IkyqNK2BG..WZOzZK7GB3_
 Wi_kipMF.E3LeC18ohsZLtvKLztwyIPjmBLeyH4rCVDvQnn6FZvej0ER3OlMNByBAYSb2psUhdTh
 hUMPZw.8oJTb0mfdzWbU8K3cPswxZ_F05xiVbRPFx3WE471On1nr.IpxspGkTFZmiiWwDRhfscVY
 U.gbl7l0qRAhkcce9helAyDsfOKoBs.dZ3i2p_I4Yu8EGG5oGcLveRGWF1qDdQWHExmFdM4joRvl
 gv83pXc3sABT44IX0a7C5r.il.Rw3cY4GTmauVvZ7nWxr8rP48NAr3FxeSq.q8GM5xYXFbPBh32P
 fibHaP8ucHLV6paxBqorHuvib.twDL3uY5ImxCqqc5tUmuA734UC8ylKaSPm6aSHFi4ZfmCiFTA3
 xku.ECvcUs1jD6uCtBF2QX9eFBy.SHxfH3RGkTMSxbYXKOstP6a56FEHnH7wnTwu_OuD_V1YIARO
 L.S156WPzUJoBD3uBt8Oj.HNSVkH9g1pmUwF3VgH1a7DRV1BlVXZQ.EtZP11.EbDqK3vUVayeMj2
 m.NvKYQvgZQWnfdHsWhKZvqvkJ01Uk.ckxmxtfDFMrlHVPEkZzgml8LetgorpxQ4fslydZcvrEky
 5NOJiDpm_aI1QmAprEbqmWaBwXh2U4wCtGN2gG9TDWXbatF0v7VjCs5zYr7YsSl5Uw_3FIMafo0H
 VJwDHj3_XEnuIU1q3wfsYLO7Yg5ZD5Zcmn99CkJeXBpG0fkq098UG7h2AgV_2ooLhIhOv0aYOEI6
 sj835Vds1pjyDD2p4b.q.MmVjAisbHeSmnw7cHbnpZ62kNFqmuhEjUi9b4tpByrfWLwp80_lhJL2
 PylOio4C3jc9pU5SuUV_yU6BXI5F7njGgSIjgH_sSphe_ajO5sFbe7k2VC0AkwicefXn.4nGzCIv
 JQt6o4Tv5CH.bfeS_t0VJzuTOVLyQjehNXAdPG_Pg3DAo2QzaHtLei9eeB2.3SfZwXhUZohm0Yr5
 lQnFDgjqhuErxDubKg0FXexZhzcNzOybHhxSNcIs3enwI5UL8FZZfk6PS6qSq9J1e69HnemXPn33
 J.Tu1H_rNYo.TnfwOA_XAPmg58J5SnmuogiqdAj77n9Bq6nwsHlALyXZvyWf6MQLzDwvQRGuvVHP
 NK_DG022vrWf62OkpLF.73dx.J5wiG7fsXAPY17.WvwMqi7jEYk1dw4ddcWujEzaBtu3040ZGEmp
 Wyjq1vYWS1f3YumaMORH4FSKUPa8PAkffl3Ik1rEFi3Kp10bdr4c0Z618RzgqZ9a3k5KBdH69Kdn
 9xkFyoYY7Vn_Bje2EwigHQfuKADJHVQRElM4AscJMt_sSR07B0UAyFOcBMB_GTcD6vpmV_ByUnEQ
 PtWw1nPhbtyVVxqQvWaYbW3R3C08l1UnnwB9WIzkTGAZmpq6MxdUaC6EtI6BjXDJjjS.NtsI5ZOM
 FcfP90MdDMOwiilVtbwpW6v5kvJXGIyfqox.jzQKuObF8iReFW5BB6h3Jg_io4QFhy3LieDUHrD1
 STAnqn5QcErxhmpBnphDih9253OltmeZX0XICuizwEaPdxyDtoriXkYnZLxY9p6k60UG_QUjVkJy
 lzi4fYA.DhHn5S4KexMt4PYDZyjbUerfbsUrytAbWykUsreCd9U3cjZAkOTbeClI3SCgftI.KCYq
 2UP0IujcxU.hWoH6jOaluJs1S2DqIAfSvh4NWrd9Wydwu_ZFPZvdrRx1Uw_qFPwqQTtA7B.xLAvw
 za0HZHOVkDP6NdlpMI4hmh0Z3doPItUpSgaTSRZ6HqTxyF0hbuLXByJVQxpqA541AmWFpBlj688E
 9XBHdFl4RzIGDugDcnrPPYwh1ERJSpA3gI5zVupCEnWSfwZlDjgfwPyBsc2HucV17ZVI7PX5aZ.q
 0zW0p4ICLCsacbM5MCTrTV7FQ_tdmRvUhdrYsLAfCkVwa81CfmTvLBPjfdPR0hU2_PgFeVhfgW9a
 urIL4dmRZfKsWQ8r16ZRxcGlTuPvn0sVO7wQ6IdPnmsogZpQ.OKrGWHc4eSMiJZYceW6Q6AUzmcJ
 NoB6JEO5dNlN9H.48FR9O1gY-
X-Sonic-MF: <mario_lohajner@rocketmail.com>
X-Sonic-ID: 1493c106-ef6b-4848-abc3-64548f28b1a5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 3 Mar 2026 13:39:04 +0000
Received: by hermes--production-ir2-bbcfb4457-v9kq7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9686c52ec99ca4522e39aaa35476498a;
          Tue, 03 Mar 2026 13:28:49 +0000 (UTC)
Message-ID: <cba02030-752e-43e1-9f65-8b726c4d42fb@rocketmail.com>
Date: Tue, 3 Mar 2026 14:28:47 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: rralloc - (former rotalloc) improved round-robin
 allocation policy
Content-Language: hr
To: Theodore Tso <tytso@mit.edu>
Cc: Andreas Dilger <adilger@dilger.ca>, libaokun1@huawei.com,
 adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, libaokun9@gmail.com
References: <20260225201520.220071-1-mario_lohajner.ref@rocketmail.com>
 <20260225201520.220071-1-mario_lohajner@rocketmail.com>
 <D135BB30-388D-4B4F-9E09-211F6DA74FCA@dilger.ca>
 <20260226024819.GA39209@macsyma-wired.lan>
 <04dfeda0-8c13-4233-b631-d8912d4fe6f0@rocketmail.com>
 <20260227011200.GA68551@macsyma-wired.lan>
 <2af6328d-5a72-476d-9768-9398a9417ea6@rocketmail.com>
 <20260227164319.GB93969@macsyma-wired.lan>
 <c156caec-e2c8-4b85-a135-0adecb56a859@rocketmail.com>
 <20260303013309.GB6520@macsyma-wired.lan>
From: Mario Lohajner <mario_lohajner@rocketmail.com>
In-Reply-To: <20260303013309.GB6520@macsyma-wired.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25198 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Queue-Id: E1B901F09DE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rocketmail.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[rocketmail.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[dilger.ca,huawei.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-14555-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rocketmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[rocketmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario_lohajner@rocketmail.com,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,rocketmail.com:dkim,rocketmail.com:mid]
X-Rspamd-Action: no action



On 03. 03. 2026. 02:33, Theodore Tso wrote:
> On Mon, Mar 02, 2026 at 09:04:44PM +0100, Mario Lohajner wrote:
>> RRALLOC spreads allocation starting points across block groups to avoid
>> repeated concentration under parallel load.
> 
> There are already other ways in which we spread allocations across
> block groups.  You need to tell explain a specific workload where this
> actually makes a difference.
> 
> Also note that in most use cases, files are written once, and read
> multiple times.  So spreading blocks across different block groups is
> can often be actively harmful.
> 
>> In high-concurrency testing, performance is consistently comparable to
>> or occasionally better than the regular allocator. No regressions have
>> been observed across tested configurations.
> 
> No regressions, and only "occasionally better" not enough of a justifiation.
> 
> What is your real life workload which is motivating your efforts?
> 
>       	     	       		      	 - Ted

RRALLOC targets sustained parallel overwrite-heavy workloads such as
scratch disks, rendering outputs, database storage and VM image storage.

It introduces a round-robin allocation policy across block groups to
reduce short-term allocation concentration under high concurrency.

It is not intended to improve write-once/read-many workloads and remains
disabled by default.

I do understand that without clearly measurable workload-specific 
improvement, this is likely not sufficient justification for upstream 
inclusion.

I will continue evaluating and refining the allocator out-of-tree.
If I am able to demonstrate concrete and reproducible benefits beyond
allocation geometry and occasional contention-related effects,
I will revisit the discussion with additional data.

Thank you for the review and valuable feedback.

Regards,
Mario Lohajner

